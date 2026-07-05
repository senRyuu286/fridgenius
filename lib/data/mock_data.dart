import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';

/// Mock data source for the UI-build phase.
///
/// TODO(backend): replace every accessor here with real Firestore / Gemini
/// calls. Nothing in this file talks to a live service.
abstract class MockData {
  static final UserProfile user = UserProfile(
    id: 'u1',
    email: 'alex@fridgenius.app',
    displayName: 'Alex Rivera',
    dietaryPreferences: const ['Vegetarian', 'High-Protein'],
    allergies: const ['Peanuts'],
    isOnboarded: true,
    createdAt: DateTime(2026, 1, 12),
  );

  static final List<Recipe> recipes = [
    const Recipe(
      id: 'r1',
      title: 'Garlic Butter Pasta',
      description:
          'A silky weeknight pasta built from pantry staples and whatever '
          'greens are wilting in the crisper.',
      prepTimeMinutes: 10,
      cookTimeMinutes: 15,
      difficulty: Difficulty.easy,
      ingredients: [
        RecipeIngredient(name: 'Spaghetti', amount: '200 g'),
        RecipeIngredient(name: 'Garlic', amount: '4 cloves'),
        RecipeIngredient(name: 'Butter', amount: '3 tbsp'),
        RecipeIngredient(name: 'Parmesan', amount: '30 g', isMissing: true),
        RecipeIngredient(name: 'Parsley', amount: 'a handful'),
      ],
      instructions: [
        'Boil the spaghetti in well-salted water until al dente.',
        'Melt butter and gently fry the sliced garlic until fragrant.',
        'Toss the drained pasta with the garlic butter and a splash of '
            'pasta water.',
        'Finish with grated parmesan and chopped parsley.',
      ],
    ),
    const Recipe(
      id: 'r2',
      title: 'Rainbow Crunch Salad',
      description:
          'Crisp, bright and ready in minutes — a fridge-clearing bowl of '
          'whatever crunchy veg you have on hand.',
      prepTimeMinutes: 15,
      cookTimeMinutes: 0,
      difficulty: Difficulty.easy,
      ingredients: [
        RecipeIngredient(name: 'Carrot', amount: '1, shredded'),
        RecipeIngredient(name: 'Red cabbage', amount: '1/4, sliced'),
        RecipeIngredient(name: 'Cucumber', amount: '1, diced'),
        RecipeIngredient(name: 'Chickpeas', amount: '1 can'),
        RecipeIngredient(name: 'Lemon', amount: '1'),
      ],
      instructions: [
        'Shred and slice all the vegetables into a large bowl.',
        'Rinse and drain the chickpeas, then add them in.',
        'Dress with lemon juice, olive oil, salt and pepper.',
        'Toss well and serve cold.',
      ],
    ),
    const Recipe(
      id: 'r3',
      title: 'Smoky Black Bean Tacos',
      description:
          'Ten-minute tacos with a smoky bean filling and a quick lime slaw.',
      prepTimeMinutes: 10,
      cookTimeMinutes: 10,
      difficulty: Difficulty.medium,
      ingredients: [
        RecipeIngredient(name: 'Black beans', amount: '1 can'),
        RecipeIngredient(name: 'Tortillas', amount: '6'),
        RecipeIngredient(name: 'Smoked paprika', amount: '1 tsp'),
        RecipeIngredient(name: 'Avocado', amount: '1', isMissing: true),
        RecipeIngredient(name: 'Lime', amount: '1'),
      ],
      instructions: [
        'Warm the beans with smoked paprika, cumin and a splash of water.',
        'Mash lightly until thickened.',
        'Char the tortillas over a flame or in a dry pan.',
        'Fill with beans, sliced avocado and a squeeze of lime.',
      ],
    ),
    const Recipe(
      id: 'r4',
      title: 'Golden Coconut Curry',
      description:
          'A cozy, fragrant curry that turns odd vegetables into something '
          'that tastes deliberate.',
      prepTimeMinutes: 15,
      cookTimeMinutes: 25,
      difficulty: Difficulty.medium,
      ingredients: [
        RecipeIngredient(name: 'Coconut milk', amount: '1 can'),
        RecipeIngredient(name: 'Curry paste', amount: '2 tbsp'),
        RecipeIngredient(name: 'Sweet potato', amount: '1, cubed'),
        RecipeIngredient(name: 'Spinach', amount: '2 handfuls'),
        RecipeIngredient(name: 'Rice', amount: 'to serve'),
      ],
      instructions: [
        'Fry the curry paste until fragrant.',
        'Add coconut milk and the cubed sweet potato; simmer until tender.',
        'Stir through the spinach until just wilted.',
        'Serve over steamed rice.',
      ],
    ),
    const Recipe(
      id: 'r5',
      title: 'Banana Oat Pancakes',
      description:
          'Three-ingredient pancakes for when breakfast has to happen fast.',
      prepTimeMinutes: 5,
      cookTimeMinutes: 10,
      difficulty: Difficulty.easy,
      ingredients: [
        RecipeIngredient(name: 'Banana', amount: '2, ripe'),
        RecipeIngredient(name: 'Oats', amount: '1 cup'),
        RecipeIngredient(name: 'Eggs', amount: '2'),
      ],
      instructions: [
        'Blend the banana, oats and eggs into a smooth batter.',
        'Ladle onto a hot, lightly greased pan.',
        'Flip when bubbles form and cook the other side.',
        'Stack and top with fruit or syrup.',
      ],
    ),
  ];

  static Recipe byId(String id) =>
      recipes.firstWhere((r) => r.id == id, orElse: () => recipes.first);

  // --- Display helpers for the image/placeholder blocks (kept in-system) ---

  static const Map<String, String> _emoji = {
    'r1': '🍝',
    'r2': '🥗',
    'r3': '🌮',
    'r4': '🍛',
    'r5': '🥞',
  };

  static const List<Color> _accents = [
    AppColors.coral,
    AppColors.gold,
    AppColors.mint,
  ];

  static String emojiOf(Recipe r) => _emoji[r.id] ?? '🍽️';

  static Color accentOf(Recipe r) =>
      _accents[r.id.hashCode.abs() % _accents.length];

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
