// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recipe _$RecipeFromJson(Map<String, dynamic> json) => _Recipe(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  prepTimeMinutes: (json['prepTimeMinutes'] as num).toInt(),
  cookTimeMinutes: (json['cookTimeMinutes'] as num).toInt(),
  difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
  ingredients: (json['ingredients'] as List<dynamic>)
      .map((e) => RecipeIngredient.fromJson(e as Map<String, dynamic>))
      .toList(),
  steps: (json['steps'] as List<dynamic>)
      .map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
      .toList(),
  imageUrl: json['imageUrl'] as String?,
  source: json['source'] as String? ?? 'gemini',
  createdBy: json['createdBy'] as String? ?? 'system',
  isCurated: json['isCurated'] as bool? ?? false,
  isPublic: json['isPublic'] as bool? ?? true,
  createdAt: _dateTimeFromTimestamp(json['createdAt']),
);

Map<String, dynamic> _$RecipeToJson(_Recipe instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'prepTimeMinutes': instance.prepTimeMinutes,
  'cookTimeMinutes': instance.cookTimeMinutes,
  'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
  'ingredients': instance.ingredients,
  'steps': instance.steps,
  'imageUrl': instance.imageUrl,
  'source': instance.source,
  'createdBy': instance.createdBy,
  'isCurated': instance.isCurated,
  'isPublic': instance.isPublic,
  'createdAt': _dateTimeToTimestamp(instance.createdAt),
};

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
};

_RecipeIngredient _$RecipeIngredientFromJson(Map<String, dynamic> json) =>
    _RecipeIngredient(
      name: json['name'] as String,
      amount: json['amount'] as String,
      isMissing: json['isMissing'] as bool? ?? false,
    );

Map<String, dynamic> _$RecipeIngredientToJson(_RecipeIngredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'isMissing': instance.isMissing,
    };

_RecipeStep _$RecipeStepFromJson(Map<String, dynamic> json) => _RecipeStep(
  order: (json['order'] as num).toInt(),
  instruction: json['instruction'] as String,
  timerSeconds: (json['timerSeconds'] as num?)?.toInt(),
  title: json['title'] as String?,
);

Map<String, dynamic> _$RecipeStepToJson(_RecipeStep instance) =>
    <String, dynamic>{
      'order': instance.order,
      'instruction': instance.instruction,
      'timerSeconds': instance.timerSeconds,
      'title': instance.title,
    };
