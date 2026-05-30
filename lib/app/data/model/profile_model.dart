import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/user_role.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String? focus,
    required String email,
    required String? bio,
    required String? location,
    @JsonKey(name: 'image_url') String? imageUrl,
    required UserRole role,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
