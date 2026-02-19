import '../../entities/note_entity.dart';

abstract class NotesRepository {
  Stream<List<NoteEntity>> watchNotes();
  Future<void> createNote(String title, String content);
  Future<void> updateNote(String id, String title, String content);
  Future<void> deleteNote(String id);
}
