import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';

/// Deterministic, purely-derived display helpers for a [Recipe] — emoji, accent
/// tile color and summary tags. These carry no backend data; they map whatever
/// recipe the app has loaded (curated, Gemini, or a favorite) onto the existing
/// neo-brutalist visual vocabulary. Assignments are keyed off the recipe id so
/// a given recipe always looks the same wherever it appears.
abstract class MockData {
  // --- Display helpers for the image/placeholder blocks (kept in-system) ---

  static const List<String> _emojiPool = [
    '🍝', '🥗', '🌮', '🍛', '🥞', '🍜', '🥘', '🍲',
    '🥙', '🍚', '🫕', '🥪', '🍳', '🧆', '🍕', '🌯',
  ];

  /// A stable, non-negative hash of the recipe id.
  static int _seed(Recipe r) {
    var hash = 0;
    for (final unit in r.id.codeUnits) {
      hash = (hash * 31 + unit) & 0x7fffffff;
    }
    return hash;
  }

  static String emojiOf(Recipe r) => _emojiPool[_seed(r) % _emojiPool.length];

  /// Assigns each recipe a vivid tile color, cycling evenly through the palette
  /// by the recipe's stable seed.
  static Color accentOf(Recipe r) =>
      AppColors.tileColors[_seed(r) % AppColors.tileColors.length];

  /// Simple display tags derived from existing fields (no model changes).
  static List<String> tagsOf(Recipe r) => [
        difficultyLabel(r.difficulty),
        '${r.totalTimeMinutes} min',
        if (r.isExactMatch) 'Ready to cook' else 'Almost there',
      ];

  static String difficultyLabel(Difficulty d) {
    switch (d) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
    }
  }
}
