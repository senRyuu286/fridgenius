// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteRecipe _$FavoriteRecipeFromJson(Map<String, dynamic> json) =>
    _FavoriteRecipe(
      id: json['id'] as String,
      userId: json['userId'] as String,
      recipe: Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
      savedAt: _dateTimeFromTimestamp(json['savedAt']),
    );

Map<String, dynamic> _$FavoriteRecipeToJson(_FavoriteRecipe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'recipe': instance.recipe.toJson(),
      'savedAt': _dateTimeToTimestamp(instance.savedAt),
    };
