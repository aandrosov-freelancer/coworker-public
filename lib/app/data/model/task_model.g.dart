// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => _TaskModel(
  id: (json['id'] as num?)?.toInt(),
  customerId: json['customer_id'] as String?,
  categoryId: (json['category_id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  budget: _parseBudget(json['budget']),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TaskModelToJson(_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'category_id': instance.categoryId,
      'title': instance.title,
      'description': instance.description,
      'budget': instance.budget,
      'created_at': instance.createdAt?.toIso8601String(),
    };
