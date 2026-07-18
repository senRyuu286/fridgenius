import 'package:flutter_test/flutter_test.dart';
import 'package:fridgenius/models/recipe.dart';

void main() {
  test('parses a real seed recipe document shape', () {
    // Mirrors an actual doc from the Firestore `recipes` collection:
    // no description/prepTimeMinutes/difficulty, steps use `stepNumber`.
    final seed = <String, dynamic>{
      'id': '2r55xqvZPGRKnjDCm60Q',
      'title': 'Chunky 5-Minute Tuna Salad',
      'cookTimeMinutes': 5,
      'isCurated': true,
      'isPublic': true,
      'createdBy': 'system',
      'ingredients': [
        {'name': 'Canned Tuna', 'amount': '1', 'unit': 'can'},
        {'name': 'Mayonnaise', 'amount': '2', 'unit': 'tbsp'},
      ],
      'steps': [
        {'stepNumber': 1, 'instruction': 'Drain the tuna.'},
        {'stepNumber': 2, 'instruction': 'Flake into a bowl.'},
      ],
    };

    final recipe = Recipe.fromJson(seed);

    expect(recipe.title, 'Chunky 5-Minute Tuna Salad');
    expect(recipe.cookTimeMinutes, 5);
    expect(recipe.prepTimeMinutes, 0); // defaulted
    expect(recipe.description, ''); // defaulted
    expect(recipe.difficulty, Difficulty.easy); // defaulted
    expect(recipe.isCurated, true);
    expect(recipe.ingredients.length, 2);
    expect(recipe.steps.first.order, 1); // read from stepNumber
    expect(recipe.steps.last.order, 2);
  });

  test('hydrated favorite (catalog recipe shape) parses', () {
    // Shape of the recipes/{recipeId} doc that fetchFavorites now hydrates
    // from, instead of the thin `recipeSnapshot` stored on the favorite.
    final catalog = <String, dynamic>{
      'id': 'fU13r0s8YsiSXj7hsX7K',
      'title': 'Curated Garlic Chicken',
      'cookTimeMinutes': 25,
      'isCurated': true,
      'ingredients': [
        {'name': 'Chicken', 'amount': '2', 'unit': 'pcs'},
      ],
      'steps': [
        {'stepNumber': 1, 'instruction': 'Sear the chicken.'},
      ],
    };

    final recipe = Recipe.fromJson(catalog);

    expect(recipe.id, 'fU13r0s8YsiSXj7hsX7K');
    expect(recipe.title, 'Curated Garlic Chicken');
    expect(recipe.ingredients.single.name, 'Chicken');
    expect(recipe.steps.single.order, 1);
  });

  test('recipe.toJson() is Firestore-safe (nested objects become maps)', () {
    const recipe = Recipe(
      id: 'r1',
      title: 'Test',
      cookTimeMinutes: 10,
      ingredients: [RecipeIngredient(name: 'Egg', amount: '2')],
      steps: [RecipeStep(order: 1, instruction: 'Crack eggs.')],
    );

    final json = recipe.toJson();

    // Nested lists must be plain Maps, not _RecipeIngredient/_RecipeStep
    // instances — otherwise Firestore .set() throws "Invalid argument".
    expect(json['ingredients'], isA<List>());
    expect((json['ingredients'] as List).single, isA<Map<String, dynamic>>());
    expect((json['steps'] as List).single, isA<Map<String, dynamic>>());
    expect((json['ingredients'] as List).single['name'], 'Egg');
  });
}
