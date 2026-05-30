// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatModel {

 String get id;@JsonKey(name: 'user1_id') String get user1Id;@JsonKey(name: 'user2_id') String get user2Id;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;// The profile of the other user, mapped from joins
@JsonKey(includeFromJson: false, includeToJson: false) ProfileModel? get otherParticipant;
/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatModelCopyWith<ChatModel> get copyWith => _$ChatModelCopyWithImpl<ChatModel>(this as ChatModel, _$identity);

  /// Serializes this ChatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.user1Id, user1Id) || other.user1Id == user1Id)&&(identical(other.user2Id, user2Id) || other.user2Id == user2Id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.otherParticipant, otherParticipant) || other.otherParticipant == otherParticipant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user1Id,user2Id,createdAt,updatedAt,otherParticipant);

@override
String toString() {
  return 'ChatModel(id: $id, user1Id: $user1Id, user2Id: $user2Id, createdAt: $createdAt, updatedAt: $updatedAt, otherParticipant: $otherParticipant)';
}


}

/// @nodoc
abstract mixin class $ChatModelCopyWith<$Res>  {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) _then) = _$ChatModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user1_id') String user1Id,@JsonKey(name: 'user2_id') String user2Id,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(includeFromJson: false, includeToJson: false) ProfileModel? otherParticipant
});


$ProfileModelCopyWith<$Res>? get otherParticipant;

}
/// @nodoc
class _$ChatModelCopyWithImpl<$Res>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._self, this._then);

  final ChatModel _self;
  final $Res Function(ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user1Id = null,Object? user2Id = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? otherParticipant = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user1Id: null == user1Id ? _self.user1Id : user1Id // ignore: cast_nullable_to_non_nullable
as String,user2Id: null == user2Id ? _self.user2Id : user2Id // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,otherParticipant: freezed == otherParticipant ? _self.otherParticipant : otherParticipant // ignore: cast_nullable_to_non_nullable
as ProfileModel?,
  ));
}
/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<$Res>? get otherParticipant {
    if (_self.otherParticipant == null) {
    return null;
  }

  return $ProfileModelCopyWith<$Res>(_self.otherParticipant!, (value) {
    return _then(_self.copyWith(otherParticipant: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatModel].
extension ChatModelPatterns on ChatModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user1_id')  String user1Id, @JsonKey(name: 'user2_id')  String user2Id, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  ProfileModel? otherParticipant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
return $default(_that.id,_that.user1Id,_that.user2Id,_that.createdAt,_that.updatedAt,_that.otherParticipant);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user1_id')  String user1Id, @JsonKey(name: 'user2_id')  String user2Id, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  ProfileModel? otherParticipant)  $default,) {final _that = this;
switch (_that) {
case _ChatModel():
return $default(_that.id,_that.user1Id,_that.user2Id,_that.createdAt,_that.updatedAt,_that.otherParticipant);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user1_id')  String user1Id, @JsonKey(name: 'user2_id')  String user2Id, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(includeFromJson: false, includeToJson: false)  ProfileModel? otherParticipant)?  $default,) {final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
return $default(_that.id,_that.user1Id,_that.user2Id,_that.createdAt,_that.updatedAt,_that.otherParticipant);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatModel implements ChatModel {
  const _ChatModel({required this.id, @JsonKey(name: 'user1_id') required this.user1Id, @JsonKey(name: 'user2_id') required this.user2Id, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(includeFromJson: false, includeToJson: false) this.otherParticipant});
  factory _ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user1_id') final  String user1Id;
@override@JsonKey(name: 'user2_id') final  String user2Id;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
// The profile of the other user, mapped from joins
@override@JsonKey(includeFromJson: false, includeToJson: false) final  ProfileModel? otherParticipant;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatModelCopyWith<_ChatModel> get copyWith => __$ChatModelCopyWithImpl<_ChatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.user1Id, user1Id) || other.user1Id == user1Id)&&(identical(other.user2Id, user2Id) || other.user2Id == user2Id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.otherParticipant, otherParticipant) || other.otherParticipant == otherParticipant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user1Id,user2Id,createdAt,updatedAt,otherParticipant);

@override
String toString() {
  return 'ChatModel(id: $id, user1Id: $user1Id, user2Id: $user2Id, createdAt: $createdAt, updatedAt: $updatedAt, otherParticipant: $otherParticipant)';
}


}

/// @nodoc
abstract mixin class _$ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$ChatModelCopyWith(_ChatModel value, $Res Function(_ChatModel) _then) = __$ChatModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user1_id') String user1Id,@JsonKey(name: 'user2_id') String user2Id,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(includeFromJson: false, includeToJson: false) ProfileModel? otherParticipant
});


@override $ProfileModelCopyWith<$Res>? get otherParticipant;

}
/// @nodoc
class __$ChatModelCopyWithImpl<$Res>
    implements _$ChatModelCopyWith<$Res> {
  __$ChatModelCopyWithImpl(this._self, this._then);

  final _ChatModel _self;
  final $Res Function(_ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user1Id = null,Object? user2Id = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? otherParticipant = freezed,}) {
  return _then(_ChatModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user1Id: null == user1Id ? _self.user1Id : user1Id // ignore: cast_nullable_to_non_nullable
as String,user2Id: null == user2Id ? _self.user2Id : user2Id // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,otherParticipant: freezed == otherParticipant ? _self.otherParticipant : otherParticipant // ignore: cast_nullable_to_non_nullable
as ProfileModel?,
  ));
}

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<$Res>? get otherParticipant {
    if (_self.otherParticipant == null) {
    return null;
  }

  return $ProfileModelCopyWith<$Res>(_self.otherParticipant!, (value) {
    return _then(_self.copyWith(otherParticipant: value));
  });
}
}

// dart format on
