import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

enum Difficulty { easy, medium, hard }

@freezed
class Recipe with _$Recipe {
  const Recipe._();

  const factory Recipe({
    required String id,
    required String title, 
    required String description, 
    
    required int prepTimeMinutes,
    required int cookTimeMinutes,
    required Difficulty difficulty,
    
    required List<RecipeIngredient> ingredients,
    required List<String> instructions,
    
    String? imageUrl,
    @Default('gemini') String source, // 'gemini' or 'curated'
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  List<RecipeIngredient> get missingIngredients => 
      ingredients.where((i) => i.isMissing).toList();

  bool get isExactMatch => missingIngredients.isEmpty;
}

@freezed
class RecipeIngredient with _$RecipeIngredient {
  const factory RecipeIngredient({
    required String name,
    required String amount, 
    
    @Default(false) bool isMissing, 
  }) = _RecipeIngredient;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) => _$RecipeIngredientFromJson(json);
}