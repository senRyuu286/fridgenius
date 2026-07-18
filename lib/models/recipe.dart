import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

enum Difficulty { easy, medium, hard }

@freezed
abstract class Recipe with _$Recipe {
  const Recipe._();

  const factory Recipe({
    required String id,
    required String title,

    // Curated/seed docs may omit these; keep tolerant defaults so the whole
    // `recipes` collection parses regardless of which writer produced it.
    @Default('') String description,
    @Default(0) int prepTimeMinutes,
    required int cookTimeMinutes,
    @JsonKey(unknownEnumValue: Difficulty.easy)
    @Default(Difficulty.easy) Difficulty difficulty,

    required List<RecipeIngredient> ingredients,
    required List<RecipeStep> steps,

    String? imageUrl,
    @Default('gemini') String source, 
    @Default('system') String createdBy,
    @Default(false) bool isCurated,
    @Default(true) bool isPublic,
    @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
    DateTime? createdAt,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  List<RecipeIngredient> get missingIngredients =>
      ingredients.where((i) => i.isMissing).toList();
  bool get isExactMatch => missingIngredients.isEmpty;
}

@freezed
abstract class RecipeIngredient with _$RecipeIngredient {
  const factory RecipeIngredient({
    required String name,
    required String amount,

    @Default(false) bool isMissing,
  }) = _RecipeIngredient;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientFromJson(json);
}

@freezed
abstract class RecipeStep with _$RecipeStep {
  const factory RecipeStep({
    // Canonical field is `order`; seed docs use `stepNumber`. Read either,
    // but always serialize back as `order`.
    @JsonKey(readValue: _readStepOrder) required int order,
    required String instruction,

    int? timerSeconds,
    String? title,
  }) = _RecipeStep;

  factory RecipeStep.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepFromJson(json);
}

Object? _readStepOrder(Map<dynamic, dynamic> json, String key) =>
    json['order'] ?? json['stepNumber'] ?? 0;

DateTime? _dateTimeFromTimestamp(dynamic timestamp) {
  if (timestamp == null) return null;
  if (timestamp is Timestamp) return timestamp.toDate();
  return null;
}

dynamic _dateTimeToTimestamp(DateTime? date) {
  if (date == null) return null;
  return Timestamp.fromDate(date);
}
