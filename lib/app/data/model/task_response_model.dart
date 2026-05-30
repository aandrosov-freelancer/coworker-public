import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_response_model.freezed.dart';
part 'task_response_model.g.dart';

@freezed
abstract class TaskResponseModel with _$TaskResponseModel {
  const factory TaskResponseModel({
    int? id,
    @JsonKey(name: 'task_id') required int taskId,
    @JsonKey(name: 'performer_id') required String performerId,
    required String message,
    @JsonKey(name: 'matching_explanation') String? matchingExplanation,
    double? coincidence,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _TaskResponseModel;

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseModelFromJson(json);
}
