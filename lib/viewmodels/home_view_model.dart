import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/mock_data.dart';
import '../models/recipe.dart';

/// ViewModel for the Home tab: the full catalogue of browsable recipes.
///
/// TODO(backend): replace the static mock list with the curated / community
/// recipe feed from Firestore.
final allRecipesProvider =
    Provider<List<Recipe>>((ref) => MockData.recipes);
