// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskResponseModel {

 int? get id;@JsonKey(name: 'task_id') int get taskId;@JsonKey(name: 'performer_id') String get performerId; String get message;@JsonKey(name: 'matching_explanation') String? get matchingExplanation; double? get coincidence;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of TaskResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskResponseModelCopyWith<TaskResponseModel> get copyWith => _$TaskResponseModelCopyWithImpl<TaskResponseModel>(this as TaskResponseModel, _$identity);

  /// Serializes this TaskResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.performerId, performerId) || other.performerId == performerId)&&(identical(other.message, message) || other.message == message)&&(identical(other.matchingExplanation, matchingExplanation) || other.matchingExplanation == matchingExplanation)&&(identical(other.coincidence, coincidence) || other.coincidence == coincidence)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,performerId,message,matchingExplanation,coincidence,createdAt);

@override
String toString() {
  return 'TaskResponseModel(id: $id, taskId: $taskId, performerId: $performerId, message: $message, matchingExplanation: $matchingExplanation, coincidence: $coincidence, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TaskResponseModelCopyWith<$Res>  {
  factory $TaskResponseModelCopyWith(TaskResponseModel value, $Res Function(TaskResponseModel) _then) = _$TaskResponseModelCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'task_id') int taskId,@JsonKey(name: 'performer_id') String performerId, String message,@JsonKey(name: 'matching_explanation') String? matchingExplanation, double? coincidence,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$TaskResponseModelCopyWithImpl<$Res>
    implements $TaskResponseModelCopyWith<$Res> {
  _$TaskResponseModelCopyWithImpl(this._self, this._then);

  final TaskResponseModel _self;
  final $Res Function(TaskResponseModel) _then;

/// Create a copy of TaskResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? taskId = null,Object? performerId = null,Object? message = null,Object? matchingExplanation = freezed,Object? coincidence = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as int,performerId: null == performerId ? _self.performerId : performerId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,matchingExplanation: freezed == matchingExplanation ? _self.matchingExplanation : matchingExplanation // ignore: cast_nullable_to_non_nullable
as String?,coincidence: freezed == coincidence ? _self.coincidence : coincidence // ignore: cast_nullable_to_non_nullable
as double?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskResponseModel].
extension TaskResponseModelPatterns on TaskResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'task_id')  int taskId, @JsonKey(name: 'performer_id')  String performerId,  String message, @JsonKey(name: 'matching_explanation')  String? matchingExplanation,  double? coincidence, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskResponseModel() when $default != null:
return $default(_that.id,_that.taskId,_that.performerId,_that.message,_that.matchingExplanation,_that.coincidence,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'task_id')  int taskId, @JsonKey(name: 'performer_id')  String performerId,  String message, @JsonKey(name: 'matching_explanation')  String? matchingExplanation,  double? coincidence, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TaskResponseModel():
return $default(_that.id,_that.taskId,_that.performerId,_that.message,_that.matchingExplanation,_that.coincidence,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'task_id')  int taskId, @JsonKey(name: 'performer_id')  String performerId,  String message, @JsonKey(name: 'matching_explanation')  String? matchingExplanation,  double? coincidence, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TaskResponseModel() when $default != null:
return $default(_that.id,_that.taskId,_that.performerId,_that.message,_that.matchingExplanation,_that.coincidence,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskResponseModel implements TaskResponseModel {
  const _TaskResponseModel({this.id, @JsonKey(name: 'task_id') required this.taskId, @JsonKey(name: 'performer_id') required this.performerId, required this.message, @JsonKey(name: 'matching_explanation') this.matchingExplanation, this.coincidence, @JsonKey(name: 'created_at') this.createdAt});
  factory _TaskResponseModel.fromJson(Map<String, dynamic> json) => _$TaskResponseModelFromJson(json);

@override final  int? id;
@override@JsonKey(name: 'task_id') final  int taskId;
@override@JsonKey(name: 'performer_id') final  String performerId;
@override final  String message;
@override@JsonKey(name: 'matching_explanation') final  String? matchingExplanation;
@override final  double? coincidence;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of TaskResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskResponseModelCopyWith<_TaskResponseModel> get copyWith => __$TaskResponseModelCopyWithImpl<_TaskResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.performerId, performerId) || other.performerId == performerId)&&(identical(other.message, message) || other.message == message)&&(identical(other.matchingExplanation, matchingExplanation) || other.matchingExplanation == matchingExplanation)&&(identical(other.coincidence, coincidence) || other.coincidence == coincidence)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,performerId,message,matchingExplanation,coincidence,createdAt);

@override
String toString() {
  return 'TaskResponseModel(id: $id, taskId: $taskId, performerId: $performerId, message: $message, matchingExplanation: $matchingExplanation, coincidence: $coincidence, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TaskResponseModelCopyWith<$Res> implements $TaskResponseModelCopyWith<$Res> {
  factory _$TaskResponseModelCopyWith(_TaskResponseModel value, $Res Function(_TaskResponseModel) _then) = __$TaskResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'task_id') int taskId,@JsonKey(name: 'performer_id') String performerId, String message,@JsonKey(name: 'matching_explanation') String? matchingExplanation, double? coincidence,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$TaskResponseModelCopyWithImpl<$Res>
    implements _$TaskResponseModelCopyWith<$Res> {
  __$TaskResponseModelCopyWithImpl(this._self, this._then);

  final _TaskResponseModel _self;
  final $Res Function(_TaskResponseModel) _then;

/// Create a copy of TaskResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? taskId = null,Object? performerId = null,Object? message = null,Object? matchingExplanation = freezed,Object? coincidence = freezed,Object? createdAt = freezed,}) {
  return _then(_TaskResponseModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as int,performerId: null == performerId ? _self.performerId : performerId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,matchingExplanation: freezed == matchingExplanation ? _self.matchingExplanation : matchingExplanation // ignore: cast_nullable_to_non_nullable
as String?,coincidence: freezed == coincidence ? _self.coincidence : coincidence // ignore: cast_nullable_to_non_nullable
as double?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
