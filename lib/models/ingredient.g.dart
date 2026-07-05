// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ingredient _$IngredientFromJson(Map<String, dynamic> json) => _Ingredient(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String?,
  emoji: json['emoji'],
  isSelected: json['isSelected'] as bool? ?? true,
);

Map<String, dynamic> _$IngredientToJson(_Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'emoji': instance.emoji,
      'isSelected': instance.isSelected,
    };
