import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class NoteModel {
  final String id;
  final String title;
  final String body;

  final int updatedAt;
  final bool isSynced;
  final bool isDeleted;
  final int version;

  NoteModel({
    required this.id,
    required this.title,
    required this.body,
    required this.updatedAt,
    required this.isSynced,
    required this.isDeleted,
    required this.version,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
