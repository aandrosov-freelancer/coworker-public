import 'package:freezed_annotation/freezed_annotation.dart';
import 'profile_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel with _$ChatModel {
  const factory ChatModel({
    required String id,
    @JsonKey(name: 'user1_id') required String user1Id,
    @JsonKey(name: 'user2_id') required String user2Id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    // The profile of the other user, mapped from joins
    @JsonKey(includeFromJson: false, includeToJson: false)
    ProfileModel? otherParticipant,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
