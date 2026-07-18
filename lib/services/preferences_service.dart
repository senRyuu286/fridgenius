import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App-wide [SharedPreferences] instance. Overridden in `main()` with the
/// resolved instance so the rest of the app can read it synchronously.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main().',
  );
});

const _kHasSignedInBefore = 'hasSignedInBefore';

/// Whether anyone has ever signed in on this device. Lets the sign-in screen
/// greet a first-time visitor differently from a returning user who logged out.
///
/// Stays `true` once set, so it persists across sign-out and app restarts.
class ReturningUserNotifier extends Notifier<bool> {
  @override
  bool build() =>
      ref.read(sharedPreferencesProvider).getBool(_kHasSignedInBefore) ?? false;

  /// Records that a successful sign-in / sign-up has happened.
  Future<void> markSignedIn() async {
    if (state) return;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_kHasSignedInBefore, true);
    state = true;
  }
}

final returningUserProvider =
    NotifierProvider<ReturningUserNotifier, bool>(ReturningUserNotifier.new);
