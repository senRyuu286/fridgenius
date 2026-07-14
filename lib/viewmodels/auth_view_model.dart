import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Streams the current Firebase auth state. Use this to react to sign-in /
/// sign-out from anywhere in the app (e.g. router redirects, profile screen).
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Owns the actual Firebase Auth calls (sign in, sign up, sign out).
/// Deliberately does NOT own form state (email/password fields, field-level
/// validation) — SignInViewModel/SignUpViewModel keep doing that locally,
/// and call into this only once their own validation passes.
class AuthViewModel extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  /// Returns null on success, or a user-facing error message on failure.
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AsyncData(null);
      return null;
    } on FirebaseAuthException catch (e, st) {
      state = AsyncError(e, st);
      return _messageFor(e);
    }
  }

  /// Returns null on success, or a user-facing error message on failure.
  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.updateDisplayName(name);
      state = const AsyncData(null);
      return null;
    } on FirebaseAuthException catch (e, st) {
      state = AsyncError(e, st);
      return _messageFor(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  String _messageFor(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found for that email';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password';
      case 'email-already-in-use':
        return 'An account already exists for that email';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Enter a valid email address';
      case 'network-request-failed':
        return 'Check your connection and try again';
      default:
        return e.message ?? 'Something went wrong. Please try again.';
    }
  }
}

final authViewModelProvider =
    NotifierProvider<AuthViewModel, AsyncValue<void>>(AuthViewModel.new);