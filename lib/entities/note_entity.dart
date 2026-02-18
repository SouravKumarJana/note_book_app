class NoteEntity {
  final String id;
  final String title;
  final String content;
  final int updatedAt;
  final bool isSynced;
  final bool isDeleted;
  final int version;

  NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.updatedAt,
    required this.isSynced,
    required this.isDeleted,
    required this.version,
  });
}
