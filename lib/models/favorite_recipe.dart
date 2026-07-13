import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'recipe.dart';

part 'favorite_recipe.freezed.dart';
part 'favorite_recipe.g.dart';

@freezed
abstract class FavoriteRecipe with _$FavoriteRecipe {
  const factory FavoriteRecipe({
    required String id, // Firestore doc id for this favorite entry
    required String userId,
    required Recipe recipe, // full snapshot, not just a reference

    @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
    DateTime? savedAt,
  }) = _FavoriteRecipe;

  factory FavoriteRecipe.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRecipeFromJson(json);
}

DateTime? _dateTimeFromTimestamp(dynamic timestamp) {
  if (timestamp == null) return null;
  if (timestamp is Timestamp) return timestamp.toDate();
  return null;
}

dynamic _dateTimeToTimestamp(DateTime? date) {
  if (date == null) return null;
  return Timestamp.fromDate(date);
}