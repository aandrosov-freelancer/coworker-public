import 'package:app/app/data/model/profile_model.dart';

class TaskResponseEntity {
  final int id;
  final String message;
  final double? coincidence;
  final String? matchingExplanation;
  final ProfileModel performer;

  TaskResponseEntity({
    required this.id,
    required this.message,
    this.coincidence,
    this.matchingExplanation,
    required this.performer,
  });

  factory TaskResponseEntity.fromJson(Map<String, dynamic> json) {
    return TaskResponseEntity(
      id: json['id'],
      message: json['message'],
      coincidence: (json['coincidence'] as num?)?.toDouble(),
      matchingExplanation: json['matching_explanation'],
      performer: ProfileModel.fromJson(json['performer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'coincidence': coincidence,
      'matching_explanation': matchingExplanation,
      'performer': performer.toJson(),
    };
  }
}
