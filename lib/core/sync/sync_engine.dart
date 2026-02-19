import 'package:get/get.dart';
import '../../data/local/notes_dao.dart';
import '../../data/local/sync_queue_dao.dart';
import '../network/rest_client.dart';
import 'retry_policy.dart';
import '../../data/models/note_model.dart';
import 'connectivity_service.dart';

class SyncEngine {
  final RestClient api = Get.find();
  final NotesDao notesDao = Get.find();
  final SyncQueueDao queueDao = Get.find();
  final ConnectivityService connectivity = Get.find();
  final RetryPolicy retryPolicy = RetryPolicy();

  bool _syncing = false;

  SyncEngine() {
    _listenConnectivity();
  }

  void _listenConnectivity() {
    connectivity.connectionStream.listen((isConnected) {
      if (isConnected) {
        trigger();
      }
    });
  }

  Future<void> trigger() async {
    if (_syncing) return;
    if (!connectivity.isConnected) return;
    _syncing = true;

    final queue = await queueDao.getAll();

    for (final item in queue) {
      try {
        final localNote = await notesDao.getById(item.noteId);
        if (localNote == null) continue;

        final noteModel = NoteModel(
          id: localNote.id,
          title: localNote.title,
          body: localNote.content,
          updatedAt: localNote.updatedAt,
          isSynced: localNote.isSynced,
          isDeleted: localNote.isDeleted,
          version: localNote.version,
        );

        switch (item.operationType) {
          case "CREATE":
            final serverNote = await retryPolicy.execute(
              () => api.createNote(noteModel),
            );
            await notesDao.replaceFromServer(serverNote);
            break;

          case "UPDATE":
            final serverNote = await retryPolicy.execute(
              () => api.updateNote(noteModel.id, noteModel),
            );
            await notesDao.replaceFromServer(serverNote);
            break;

          case "DELETE":
            await retryPolicy.execute(
              () => api.deleteNote(item.noteId),
            );
            break;
        }

        await queueDao.remove(item.id);
      } catch (e) {
        if (item.retryCount >= 3) {
          await queueDao.remove(item.id);
        } else {
          await queueDao.incrementRetry(item.id);
        }
      }
    }

    await _pullFromServer();

    _syncing = false;
  }

  Future<void> _pullFromServer() async {
    try {
      final remoteNotes = await api.getAllNotes();

      for (final remote in remoteNotes) {
        final local = await notesDao.getById(remote.id);

        if (local == null) {
          await notesDao.replaceFromServer(remote);
        } else if (remote.version > local.version) {
          await notesDao.replaceFromServer(remote);
        }
      }
    } catch (_) {}
  }
}
