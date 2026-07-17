import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/ingredient_detector.dart';

/// Immutable state for the camera ingredient scan.
class ScanState {
  const ScanState({
    this.detecting = false,
    this.detected = const [],
    this.error,
    this.hasScanned = false,
  });

  /// True while ML Kit is processing a captured photo.
  final bool detecting;

  /// The editable list of detected ingredient names (reviewed before use).
  final List<String> detected;

  /// User-facing error message if detection failed.
  final String? error;

  /// True once at least one detection pass has completed (drives the switch
  /// from the live camera to the review UI).
  final bool hasScanned;
}

/// ViewModel for the camera scan: runs on-device detection on a captured photo
/// and owns the editable list of detected ingredients the user reviews before
/// generating recipes.
class CameraScanViewModel extends Notifier<ScanState> {
  @override
  ScanState build() => const ScanState();

  /// Runs detection on the photo at [imagePath].
  Future<void> detect(String imagePath) async {
    state = const ScanState(detecting: true);
    try {
      final found =
          await ref.read(ingredientDetectorProvider).detectFromImage(imagePath);
      state = ScanState(detected: found, hasScanned: true);
    } catch (_) {
      state = const ScanState(
        hasScanned: true,
        error: 'We couldn\'t read that photo. Try again with better lighting.',
      );
    }
  }

  /// Adds a manually-typed ingredient, ignoring blanks and case-insensitive
  /// duplicates.
  void add(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    if (state.detected.any((d) => d.toLowerCase() == trimmed.toLowerCase())) {
      return;
    }
    state = ScanState(
      detected: [...state.detected, trimmed],
      hasScanned: state.hasScanned,
    );
  }

  void remove(String name) {
    state = ScanState(
      detected: state.detected.where((d) => d != name).toList(),
      hasScanned: state.hasScanned,
    );
  }

  /// Clears the scan to return to the live camera (e.g. "Retake").
  void reset() => state = const ScanState();
}

final cameraScanProvider =
    NotifierProvider<CameraScanViewModel, ScanState>(CameraScanViewModel.new);
