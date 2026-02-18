import 'package:drift/drift.dart';
import 'app_database.dart';

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

}
