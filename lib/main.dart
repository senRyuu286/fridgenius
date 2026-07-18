import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'router/app_router.dart';
import 'services/preferences_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    providerAndroid: AndroidDebugProvider(),
    providerApple: AppleAppAttestProvider()
  );
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const FridgeniusApp(),
    ),
  );
}

class FridgeniusApp extends ConsumerWidget {
  const FridgeniusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Fridgenius',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      scrollBehavior: const _NoStretchScrollBehavior(),
      routerConfig: router,
    );
  }
}

/// App-wide scroll behavior that removes the Android overscroll *stretch*
/// (and glow) indicator, so lists don't visibly stretch when pulled past their
/// ends. Everything else keeps Material defaults.
class _NoStretchScrollBehavior extends MaterialScrollBehavior {
  const _NoStretchScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
