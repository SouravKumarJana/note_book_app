import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../core/sync/sync_engine.dart';
import '../../entities/note_entity.dart';
import '../repositories/notes_repository.dart';
import '../local/app_database.dart';
import '../local/notes_dao.dart';
import '../local/sync_queue_dao.dart';

class NotesRepositoryImplement implements NotesRepository {
  final NotesDao notesDao = Get.find();
  final SyncQueueDao queueDao = Get.find();
  final SyncEngine syncEngine = Get.find();

  @override
  Stream<List<NoteEntity>> watchNotes() {
    return notesDao.watchNotes().map((list) =>
        list.map((e) => NoteEntity(
              id: e.id,
              title: e.title,
              content: e.content,
              updatedAt: e.updatedAt,
              isSynced: e.isSynced,
              isDeleted: e.isDeleted,
              version: e.version,
            )).toList());
  }

  @override
  Future<void> createNote(String title, String content) async {
    final id = const Uuid().v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    await notesDao.insertNote(
      NotesCompanion.insert(
        id: id,
        title: title,
        content: content,
        updatedAt: now,
        isSynced: false,
        isDeleted: false,
        version: 1,
      ),
    );

    await queueDao.add(id, "CREATE");
    syncEngine.trigger();
  }

  @override
  Future<void> deleteNote(String id) async {
    await notesDao.softDelete(id);
    await queueDao.add(id, "DELETE");
    syncEngine.trigger();
  }
}
