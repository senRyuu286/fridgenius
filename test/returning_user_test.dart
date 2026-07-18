import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fridgenius/services/preferences_service.dart';

ProviderContainer _containerWith(SharedPreferences prefs) {
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('new user (no stored flag) is not a returning user', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = _containerWith(prefs);

    expect(container.read(returningUserProvider), isFalse);
  });

  test('stored flag makes the user returning', () async {
    SharedPreferences.setMockInitialValues({'hasSignedInBefore': true});
    final prefs = await SharedPreferences.getInstance();
    final container = _containerWith(prefs);

    expect(container.read(returningUserProvider), isTrue);
  });

  test('markSignedIn flips and persists the flag', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = _containerWith(prefs);

    expect(container.read(returningUserProvider), isFalse);
    await container.read(returningUserProvider.notifier).markSignedIn();

    expect(container.read(returningUserProvider), isTrue);
    expect(prefs.getBool('hasSignedInBefore'), isTrue);
  });
}
