// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => _ChatModel(
  id: json['id'] as String,
  user1Id: json['user1_id'] as String,
  user2Id: json['user2_id'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ChatModelToJson(_ChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user1_id': instance.user1Id,
      'user2_id': instance.user2Id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
