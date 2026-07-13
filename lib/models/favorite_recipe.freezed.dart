// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_recipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteRecipe {

 String get id; String get userId; Recipe get recipe;@JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp) DateTime? get savedAt;
/// Create a copy of FavoriteRecipe
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteRecipeCopyWith<FavoriteRecipe> get copyWith => _$FavoriteRecipeCopyWithImpl<FavoriteRecipe>(this as FavoriteRecipe, _$identity);

  /// Serializes this FavoriteRecipe to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteRecipe&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.recipe, recipe) || other.recipe == recipe)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,recipe,savedAt);

@override
String toString() {
  return 'FavoriteRecipe(id: $id, userId: $userId, recipe: $recipe, savedAt: $savedAt)';
}


}

/// @nodoc
abstract mixin class $FavoriteRecipeCopyWith<$Res>  {
  factory $FavoriteRecipeCopyWith(FavoriteRecipe value, $Res Function(FavoriteRecipe) _then) = _$FavoriteRecipeCopyWithImpl;
@useResult
$Res call({
 String id, String userId, Recipe recipe,@JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp) DateTime? savedAt
});


$RecipeCopyWith<$Res> get recipe;

}
/// @nodoc
class _$FavoriteRecipeCopyWithImpl<$Res>
    implements $FavoriteRecipeCopyWith<$Res> {
  _$FavoriteRecipeCopyWithImpl(this._self, this._then);

  final FavoriteRecipe _self;
  final $Res Function(FavoriteRecipe) _then;

/// Create a copy of FavoriteRecipe
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? recipe = null,Object? savedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,recipe: null == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as Recipe,savedAt: freezed == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of FavoriteRecipe
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeCopyWith<$Res> get recipe {
  
  return $RecipeCopyWith<$Res>(_self.recipe, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}
}


/// Adds pattern-matching-related methods to [FavoriteRecipe].
extension FavoriteRecipePatterns on FavoriteRecipe {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteRecipe value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteRecipe() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteRecipe value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteRecipe():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteRecipe value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteRecipe() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  Recipe recipe, @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)  DateTime? savedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteRecipe() when $default != null:
return $default(_that.id,_that.userId,_that.recipe,_that.savedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  Recipe recipe, @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)  DateTime? savedAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteRecipe():
return $default(_that.id,_that.userId,_that.recipe,_that.savedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  Recipe recipe, @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)  DateTime? savedAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteRecipe() when $default != null:
return $default(_that.id,_that.userId,_that.recipe,_that.savedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteRecipe implements FavoriteRecipe {
  const _FavoriteRecipe({required this.id, required this.userId, required this.recipe, @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp) this.savedAt});
  factory _FavoriteRecipe.fromJson(Map<String, dynamic> json) => _$FavoriteRecipeFromJson(json);

@override final  String id;
@override final  String userId;
@override final  Recipe recipe;
@override@JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp) final  DateTime? savedAt;

/// Create a copy of FavoriteRecipe
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteRecipeCopyWith<_FavoriteRecipe> get copyWith => __$FavoriteRecipeCopyWithImpl<_FavoriteRecipe>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteRecipeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteRecipe&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.recipe, recipe) || other.recipe == recipe)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,recipe,savedAt);

@override
String toString() {
  return 'FavoriteRecipe(id: $id, userId: $userId, recipe: $recipe, savedAt: $savedAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteRecipeCopyWith<$Res> implements $FavoriteRecipeCopyWith<$Res> {
  factory _$FavoriteRecipeCopyWith(_FavoriteRecipe value, $Res Function(_FavoriteRecipe) _then) = __$FavoriteRecipeCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, Recipe recipe,@JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp) DateTime? savedAt
});


@override $RecipeCopyWith<$Res> get recipe;

}
/// @nodoc
class __$FavoriteRecipeCopyWithImpl<$Res>
    implements _$FavoriteRecipeCopyWith<$Res> {
  __$FavoriteRecipeCopyWithImpl(this._self, this._then);

  final _FavoriteRecipe _self;
  final $Res Function(_FavoriteRecipe) _then;

/// Create a copy of FavoriteRecipe
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? recipe = null,Object? savedAt = freezed,}) {
  return _then(_FavoriteRecipe(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,recipe: null == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as Recipe,savedAt: freezed == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of FavoriteRecipe
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeCopyWith<$Res> get recipe {
  
  return $RecipeCopyWith<$Res>(_self.recipe, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}
}

// dart format on
