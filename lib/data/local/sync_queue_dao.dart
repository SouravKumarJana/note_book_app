import 'app_database.dart';
import 'package:drift/drift.dart';
class SyncQueueDao {
  final AppDatabase db;
  SyncQueueDao(this.db);

  Future<void> add(String id, String type) =>
      db.into(db.syncQueue).insert(
            SyncQueueCompanion.insert(
              noteId: id,
              operationType: type,
            ),
          );

  Future<List<SyncQueueData>> getAll() =>
      db.select(db.syncQueue).get();

  Future<void> remove(int id) =>
      (db.delete(db.syncQueue)..where((t) => t.id.equals(id))).go();
  
  Future<void> incrementRetry(int id) async {
    final item = await (db.select(db.syncQueue)
          ..where((t) => t.id.equals(id)))
        .getSingle();

    await (db.update(db.syncQueue)
          ..where((t) => t.id.equals(id)))
        .write(
      SyncQueueCompanion(
        retryCount: Value(item.retryCount + 1),
      ),
    );
  }

}
