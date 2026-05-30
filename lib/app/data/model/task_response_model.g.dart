// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskResponseModel _$TaskResponseModelFromJson(Map<String, dynamic> json) =>
    _TaskResponseModel(
      id: (json['id'] as num?)?.toInt(),
      taskId: (json['task_id'] as num).toInt(),
      performerId: json['performer_id'] as String,
      message: json['message'] as String,
      matchingExplanation: json['matching_explanation'] as String?,
      coincidence: (json['coincidence'] as num?)?.toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TaskResponseModelToJson(_TaskResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'performer_id': instance.performerId,
      'message': instance.message,
      'matching_explanation': instance.matchingExplanation,
      'coincidence': instance.coincidence,
      'created_at': instance.createdAt?.toIso8601String(),
    };
