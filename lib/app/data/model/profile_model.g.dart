// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      focus: json['focus'] as String?,
      email: json['email'] as String,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      imageUrl: json['image_url'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'focus': instance.focus,
      'email': instance.email,
      'bio': instance.bio,
      'location': instance.location,
      'image_url': instance.imageUrl,
      'role': _$UserRoleEnumMap[instance.role]!,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.performer: 'performer',
  UserRole.customer: 'customer',
};
