// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
  id: json['id'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  updatedAt: (json['updatedAt'] as num).toInt(),
  isSynced: json['isSynced'] as bool,
  isDeleted: json['isDeleted'] as bool,
  version: (json['version'] as num).toInt(),
);

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'updatedAt': instance.updatedAt,
  'isSynced': instance.isSynced,
  'isDeleted': instance.isDeleted,
  'version': instance.version,
};
