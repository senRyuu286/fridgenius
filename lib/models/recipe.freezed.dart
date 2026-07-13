// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Recipe {

 String get id; String get title; String get description; int get prepTimeMinutes; int get cookTimeMinutes; Difficulty get difficulty; List<RecipeIngredient> get ingredients; List<RecipeStep> get steps; String? get imageUrl; String get source;
/// Create a copy of Recipe
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeCopyWith<Recipe> get copyWith => _$RecipeCopyWithImpl<Recipe>(this as Recipe, _$identity);

  /// Serializes this Recipe to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Recipe&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.prepTimeMinutes, prepTimeMinutes) || other.prepTimeMinutes == prepTimeMinutes)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&const DeepCollectionEquality().equals(other.ingredients, ingredients)&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,prepTimeMinutes,cookTimeMinutes,difficulty,const DeepCollectionEquality().hash(ingredients),const DeepCollectionEquality().hash(steps),imageUrl,source);

@override
String toString() {
  return 'Recipe(id: $id, title: $title, description: $description, prepTimeMinutes: $prepTimeMinutes, cookTimeMinutes: $cookTimeMinutes, difficulty: $difficulty, ingredients: $ingredients, steps: $steps, imageUrl: $imageUrl, source: $source)';
}


}

/// @nodoc
abstract mixin class $RecipeCopyWith<$Res>  {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) _then) = _$RecipeCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, int prepTimeMinutes, int cookTimeMinutes, Difficulty difficulty, List<RecipeIngredient> ingredients, List<RecipeStep> steps, String? imageUrl, String source
});




}
/// @nodoc
class _$RecipeCopyWithImpl<$Res>
    implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._self, this._then);

  final Recipe _self;
  final $Res Function(Recipe) _then;

/// Create a copy of Recipe
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? prepTimeMinutes = null,Object? cookTimeMinutes = null,Object? difficulty = null,Object? ingredients = null,Object? steps = null,Object? imageUrl = freezed,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,prepTimeMinutes: null == prepTimeMinutes ? _self.prepTimeMinutes : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,cookTimeMinutes: null == cookTimeMinutes ? _self.cookTimeMinutes : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,ingredients: null == ingredients ? _self.ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeIngredient>,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<RecipeStep>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Recipe].
extension RecipePatterns on Recipe {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Recipe value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Recipe() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Recipe value)  $default,){
final _that = this;
switch (_that) {
case _Recipe():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Recipe value)?  $default,){
final _that = this;
switch (_that) {
case _Recipe() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  int prepTimeMinutes,  int cookTimeMinutes,  Difficulty difficulty,  List<RecipeIngredient> ingredients,  List<RecipeStep> steps,  String? imageUrl,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Recipe() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.prepTimeMinutes,_that.cookTimeMinutes,_that.difficulty,_that.ingredients,_that.steps,_that.imageUrl,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  int prepTimeMinutes,  int cookTimeMinutes,  Difficulty difficulty,  List<RecipeIngredient> ingredients,  List<RecipeStep> steps,  String? imageUrl,  String source)  $default,) {final _that = this;
switch (_that) {
case _Recipe():
return $default(_that.id,_that.title,_that.description,_that.prepTimeMinutes,_that.cookTimeMinutes,_that.difficulty,_that.ingredients,_that.steps,_that.imageUrl,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  int prepTimeMinutes,  int cookTimeMinutes,  Difficulty difficulty,  List<RecipeIngredient> ingredients,  List<RecipeStep> steps,  String? imageUrl,  String source)?  $default,) {final _that = this;
switch (_that) {
case _Recipe() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.prepTimeMinutes,_that.cookTimeMinutes,_that.difficulty,_that.ingredients,_that.steps,_that.imageUrl,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Recipe extends Recipe {
  const _Recipe({required this.id, required this.title, required this.description, required this.prepTimeMinutes, required this.cookTimeMinutes, required this.difficulty, required final  List<RecipeIngredient> ingredients, required final  List<RecipeStep> steps, this.imageUrl, this.source = 'gemini'}): _ingredients = ingredients,_steps = steps,super._();
  factory _Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  int prepTimeMinutes;
@override final  int cookTimeMinutes;
@override final  Difficulty difficulty;
 final  List<RecipeIngredient> _ingredients;
@override List<RecipeIngredient> get ingredients {
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredients);
}

 final  List<RecipeStep> _steps;
@override List<RecipeStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  String? imageUrl;
@override@JsonKey() final  String source;

/// Create a copy of Recipe
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeCopyWith<_Recipe> get copyWith => __$RecipeCopyWithImpl<_Recipe>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Recipe&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.prepTimeMinutes, prepTimeMinutes) || other.prepTimeMinutes == prepTimeMinutes)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&const DeepCollectionEquality().equals(other._ingredients, _ingredients)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,prepTimeMinutes,cookTimeMinutes,difficulty,const DeepCollectionEquality().hash(_ingredients),const DeepCollectionEquality().hash(_steps),imageUrl,source);

@override
String toString() {
  return 'Recipe(id: $id, title: $title, description: $description, prepTimeMinutes: $prepTimeMinutes, cookTimeMinutes: $cookTimeMinutes, difficulty: $difficulty, ingredients: $ingredients, steps: $steps, imageUrl: $imageUrl, source: $source)';
}


}

/// @nodoc
abstract mixin class _$RecipeCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$RecipeCopyWith(_Recipe value, $Res Function(_Recipe) _then) = __$RecipeCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, int prepTimeMinutes, int cookTimeMinutes, Difficulty difficulty, List<RecipeIngredient> ingredients, List<RecipeStep> steps, String? imageUrl, String source
});




}
/// @nodoc
class __$RecipeCopyWithImpl<$Res>
    implements _$RecipeCopyWith<$Res> {
  __$RecipeCopyWithImpl(this._self, this._then);

  final _Recipe _self;
  final $Res Function(_Recipe) _then;

/// Create a copy of Recipe
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? prepTimeMinutes = null,Object? cookTimeMinutes = null,Object? difficulty = null,Object? ingredients = null,Object? steps = null,Object? imageUrl = freezed,Object? source = null,}) {
  return _then(_Recipe(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,prepTimeMinutes: null == prepTimeMinutes ? _self.prepTimeMinutes : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,cookTimeMinutes: null == cookTimeMinutes ? _self.cookTimeMinutes : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,ingredients: null == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeIngredient>,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<RecipeStep>,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RecipeIngredient {

 String get name; String get amount; bool get isMissing;
/// Create a copy of RecipeIngredient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeIngredientCopyWith<RecipeIngredient> get copyWith => _$RecipeIngredientCopyWithImpl<RecipeIngredient>(this as RecipeIngredient, _$identity);

  /// Serializes this RecipeIngredient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeIngredient&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,amount,isMissing);

@override
String toString() {
  return 'RecipeIngredient(name: $name, amount: $amount, isMissing: $isMissing)';
}


}

/// @nodoc
abstract mixin class $RecipeIngredientCopyWith<$Res>  {
  factory $RecipeIngredientCopyWith(RecipeIngredient value, $Res Function(RecipeIngredient) _then) = _$RecipeIngredientCopyWithImpl;
@useResult
$Res call({
 String name, String amount, bool isMissing
});




}
/// @nodoc
class _$RecipeIngredientCopyWithImpl<$Res>
    implements $RecipeIngredientCopyWith<$Res> {
  _$RecipeIngredientCopyWithImpl(this._self, this._then);

  final RecipeIngredient _self;
  final $Res Function(RecipeIngredient) _then;

/// Create a copy of RecipeIngredient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? amount = null,Object? isMissing = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isMissing: null == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeIngredient].
extension RecipeIngredientPatterns on RecipeIngredient {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeIngredient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeIngredient() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeIngredient value)  $default,){
final _that = this;
switch (_that) {
case _RecipeIngredient():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeIngredient value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeIngredient() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String amount,  bool isMissing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeIngredient() when $default != null:
return $default(_that.name,_that.amount,_that.isMissing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String amount,  bool isMissing)  $default,) {final _that = this;
switch (_that) {
case _RecipeIngredient():
return $default(_that.name,_that.amount,_that.isMissing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String amount,  bool isMissing)?  $default,) {final _that = this;
switch (_that) {
case _RecipeIngredient() when $default != null:
return $default(_that.name,_that.amount,_that.isMissing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeIngredient implements RecipeIngredient {
  const _RecipeIngredient({required this.name, required this.amount, this.isMissing = false});
  factory _RecipeIngredient.fromJson(Map<String, dynamic> json) => _$RecipeIngredientFromJson(json);

@override final  String name;
@override final  String amount;
@override@JsonKey() final  bool isMissing;

/// Create a copy of RecipeIngredient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeIngredientCopyWith<_RecipeIngredient> get copyWith => __$RecipeIngredientCopyWithImpl<_RecipeIngredient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeIngredientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeIngredient&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,amount,isMissing);

@override
String toString() {
  return 'RecipeIngredient(name: $name, amount: $amount, isMissing: $isMissing)';
}


}

/// @nodoc
abstract mixin class _$RecipeIngredientCopyWith<$Res> implements $RecipeIngredientCopyWith<$Res> {
  factory _$RecipeIngredientCopyWith(_RecipeIngredient value, $Res Function(_RecipeIngredient) _then) = __$RecipeIngredientCopyWithImpl;
@override @useResult
$Res call({
 String name, String amount, bool isMissing
});




}
/// @nodoc
class __$RecipeIngredientCopyWithImpl<$Res>
    implements _$RecipeIngredientCopyWith<$Res> {
  __$RecipeIngredientCopyWithImpl(this._self, this._then);

  final _RecipeIngredient _self;
  final $Res Function(_RecipeIngredient) _then;

/// Create a copy of RecipeIngredient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? amount = null,Object? isMissing = null,}) {
  return _then(_RecipeIngredient(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isMissing: null == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RecipeStep {

 int get order; String get instruction; int? get timerSeconds; String? get title;
/// Create a copy of RecipeStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeStepCopyWith<RecipeStep> get copyWith => _$RecipeStepCopyWithImpl<RecipeStep>(this as RecipeStep, _$identity);

  /// Serializes this RecipeStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeStep&&(identical(other.order, order) || other.order == order)&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.timerSeconds, timerSeconds) || other.timerSeconds == timerSeconds)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,instruction,timerSeconds,title);

@override
String toString() {
  return 'RecipeStep(order: $order, instruction: $instruction, timerSeconds: $timerSeconds, title: $title)';
}


}

/// @nodoc
abstract mixin class $RecipeStepCopyWith<$Res>  {
  factory $RecipeStepCopyWith(RecipeStep value, $Res Function(RecipeStep) _then) = _$RecipeStepCopyWithImpl;
@useResult
$Res call({
 int order, String instruction, int? timerSeconds, String? title
});




}
/// @nodoc
class _$RecipeStepCopyWithImpl<$Res>
    implements $RecipeStepCopyWith<$Res> {
  _$RecipeStepCopyWithImpl(this._self, this._then);

  final RecipeStep _self;
  final $Res Function(RecipeStep) _then;

/// Create a copy of RecipeStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? instruction = null,Object? timerSeconds = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,timerSeconds: freezed == timerSeconds ? _self.timerSeconds : timerSeconds // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeStep].
extension RecipeStepPatterns on RecipeStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeStep value)  $default,){
final _that = this;
switch (_that) {
case _RecipeStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeStep value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int order,  String instruction,  int? timerSeconds,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeStep() when $default != null:
return $default(_that.order,_that.instruction,_that.timerSeconds,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int order,  String instruction,  int? timerSeconds,  String? title)  $default,) {final _that = this;
switch (_that) {
case _RecipeStep():
return $default(_that.order,_that.instruction,_that.timerSeconds,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int order,  String instruction,  int? timerSeconds,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _RecipeStep() when $default != null:
return $default(_that.order,_that.instruction,_that.timerSeconds,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeStep implements RecipeStep {
  const _RecipeStep({required this.order, required this.instruction, this.timerSeconds, this.title});
  factory _RecipeStep.fromJson(Map<String, dynamic> json) => _$RecipeStepFromJson(json);

@override final  int order;
@override final  String instruction;
@override final  int? timerSeconds;
@override final  String? title;

/// Create a copy of RecipeStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeStepCopyWith<_RecipeStep> get copyWith => __$RecipeStepCopyWithImpl<_RecipeStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeStep&&(identical(other.order, order) || other.order == order)&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.timerSeconds, timerSeconds) || other.timerSeconds == timerSeconds)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,instruction,timerSeconds,title);

@override
String toString() {
  return 'RecipeStep(order: $order, instruction: $instruction, timerSeconds: $timerSeconds, title: $title)';
}


}

/// @nodoc
abstract mixin class _$RecipeStepCopyWith<$Res> implements $RecipeStepCopyWith<$Res> {
  factory _$RecipeStepCopyWith(_RecipeStep value, $Res Function(_RecipeStep) _then) = __$RecipeStepCopyWithImpl;
@override @useResult
$Res call({
 int order, String instruction, int? timerSeconds, String? title
});




}
/// @nodoc
class __$RecipeStepCopyWithImpl<$Res>
    implements _$RecipeStepCopyWith<$Res> {
  __$RecipeStepCopyWithImpl(this._self, this._then);

  final _RecipeStep _self;
  final $Res Function(_RecipeStep) _then;

/// Create a copy of RecipeStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? instruction = null,Object? timerSeconds = freezed,Object? title = freezed,}) {
  return _then(_RecipeStep(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,timerSeconds: freezed == timerSeconds ? _self.timerSeconds : timerSeconds // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
