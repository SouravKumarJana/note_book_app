import 'package:drift/drift.dart';
import 'app_database.dart';
import '../models/note_model.dart';

class NotesDao {
  final AppDatabase db;
  NotesDao(this.db);

  Stream<List<Note>> watchNotes() =>
      (db.select(db.notes)..where((t) => t.isDeleted.equals(false))).watch();

  Future<void> insertNote(NotesCompanion note) =>
      db.into(db.notes).insert(note);

  Future<void> markSynced(String id) =>
      (db.update(db.notes)..where((t) => t.id.equals(id)))
          .write(const NotesCompanion(isSynced: Value(true)));

  Future<void> softDelete(String id) =>
      (db.update(db.notes)..where((t) => t.id.equals(id)))
          .write(const NotesCompanion(isDeleted: Value(true)));
          
  Future<Note?> getById(String id) =>
    (db.select(db.notes)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> updateNote(String id, String title, String content,int updatedAt) =>
    (db.update(db.notes)..where((t) => t.id.equals(id))).write(
      NotesCompanion(
        title: Value(title),
        content: Value(content),
        updatedAt: Value(updatedAt),
        isSynced: const Value(false),
      ),
    );

Future<void> replaceFromServer(NoteModel model) =>
    (db.update(db.notes)..where((t) => t.id.equals(model.id))).write(
      NotesCompanion(
        title: Value(model.title),
        content: Value(model.body),
        updatedAt: Value(model.updatedAt),
        version: Value(model.version),
        isSynced: const Value(true),
        isDeleted: Value(model.isDeleted),
      ),
    );

}



