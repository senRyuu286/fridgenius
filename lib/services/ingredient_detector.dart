import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Detects likely food ingredients from a captured photo.
abstract interface class IngredientDetector {
  /// Returns distinct, food-related labels found in the image at [imagePath],
  /// ordered by the detector's confidence (most confident first). May be empty
  /// if nothing food-like is recognized.
  Future<List<String>> detectFromImage(String imagePath);
}

/// On-device [IngredientDetector] backed by Google ML Kit image labeling.
///
/// ML Kit's default model returns generic scene labels, so results are filtered
/// against a food allowlist to keep only ingredient-like labels. Detection is
/// coarse by design — the scan screen lets the user review and edit the result
/// before generating recipes.
class MlKitIngredientDetector implements IngredientDetector {
  MlKitIngredientDetector({double confidenceThreshold = 0.5})
      : _labeler = ImageLabeler(
          options: ImageLabelerOptions(confidenceThreshold: confidenceThreshold),
        );

  final ImageLabeler _labeler;

  @override
  Future<List<String>> detectFromImage(String imagePath) async {
    final labels =
        await _labeler.processImage(InputImage.fromFilePath(imagePath));
    // processImage already returns labels sorted by descending confidence.
    final seen = <String>{};
    final result = <String>[];
    for (final label in labels) {
      final key = label.label.toLowerCase();
      if (!_foodLabels.contains(key)) continue;
      if (seen.add(key)) result.add(label.label);
    }
    return result;
  }

  /// Releases the native detector. Call once when the detector is no longer
  /// needed (wired to the provider's dispose).
  Future<void> dispose() => _labeler.close();

  /// Food-related entries from ML Kit's default image-labeling label map.
  static const Set<String> _foodLabels = {
    'apple', 'artichoke', 'asparagus', 'avocado', 'bacon', 'bagel', 'banana',
    'beef', 'berry', 'bread', 'broccoli', 'burrito', 'butter', 'cabbage',
    'cake', 'candy', 'carrot', 'cauliflower', 'celery', 'cheese', 'cherry',
    'chicken', 'chili', 'chocolate', 'coconut', 'coffee', 'cookie', 'corn',
    'crab', 'cucumber', 'curry', 'dessert', 'doughnut', 'egg', 'eggplant',
    'fish', 'food', 'french fries', 'fruit', 'garlic', 'ginger', 'grape',
    'hamburger', 'honey', 'hot dog', 'ice cream', 'juice', 'ketchup', 'lemon',
    'lettuce', 'lime', 'lobster', 'mango', 'meal', 'meat', 'milk', 'mushroom',
    'noodle', 'nut', 'oatmeal', 'oil', 'olive', 'onion', 'orange', 'pancake',
    'pasta', 'pastry', 'pea', 'peach', 'peanut', 'pear', 'pepper', 'pickle',
    'pineapple', 'pizza', 'popcorn', 'pork', 'potato', 'pumpkin', 'radish',
    'rice', 'salad', 'salmon', 'sandwich', 'sauce', 'sausage', 'seafood',
    'shrimp', 'spinach', 'squash', 'steak', 'strawberry', 'sushi', 'tomato',
    'vegetable', 'waffle', 'watermelon', 'wine', 'yogurt', 'zucchini',
  };
}

/// Injects the app-wide [IngredientDetector]. Override in tests with a fake.
final ingredientDetectorProvider = Provider<IngredientDetector>((ref) {
  final detector = MlKitIngredientDetector();
  ref.onDispose(detector.dispose);
  return detector;
});
