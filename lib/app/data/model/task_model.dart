import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

double _parseBudget(dynamic value) {
  if (value is num) return value.toDouble();
  if (value is String) {
    // Remove currency symbols and commas
    final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }
  return 0.0;
}

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    int? id,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'category_id') required int categoryId,
    required String title,
    required String description,
    @JsonKey(fromJson: _parseBudget) required double budget,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
