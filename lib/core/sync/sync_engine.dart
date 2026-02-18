import 'package:get/get.dart';
import '../../data/local/notes_dao.dart';
import '../../data/local/sync_queue_dao.dart';
import '../network/rest_client.dart';
import 'retry_policy.dart';
import '../../data/models/note_model.dart';

class SyncEngine {
  final RestClient api = Get.find();
  final NotesDao notesDao = Get.find();
  final SyncQueueDao queueDao = Get.find();
  final RetryPolicy retryPolicy = RetryPolicy();

  bool _syncing = false;

  Future<void> trigger() async {
    if (_syncing) return;
    _syncing = true;

    final queue = await queueDao.getAll();

    for (final item in queue) {
      try {
        final localNote = await notesDao.getById(item.noteId);
        if (localNote == null) continue;

        // Convert Drift Note → NoteModel
        final noteModel = NoteModel(
          id: localNote.id,
          title: localNote.title,
          body: localNote.content,
          updatedAt: localNote.updatedAt,
          isSynced: localNote.isSynced,
          isDeleted: localNote.isDeleted,
          version: localNote.version,
        );

        if (item.operationType == "CREATE") {
          await retryPolicy.execute(() => api.createNote(noteModel));
        }

        if (item.operationType == "DELETE") {
          await retryPolicy.execute(() => api.deleteNote(item.noteId));
        }

        await notesDao.markSynced(item.noteId);
        await queueDao.remove(item.id);

      } catch (e) {
        if (item.retryCount >= 3) {
          await queueDao.remove(item.id);
        } else {
          await queueDao.incrementRetry(item.id);
        }
      }

    }

    _syncing = false;
  }
}
