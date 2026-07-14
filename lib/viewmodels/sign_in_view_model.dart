import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_view_model.dart';

/// Immutable state for the Sign In form.
class SignInState {
  const SignInState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.authError,
  });

  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final String? authError; // set when Firebase rejects the sign-in

  SignInState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    String? authError,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      authError: authError,
    );
  }
}

/// ViewModel for Sign In. Local field validation stays mock/instant;
/// the actual account check is delegated to AuthViewModel.
class SignInViewModel extends Notifier<SignInState> {
  @override
  SignInState build() => const SignInState();

  void setEmail(String value) => state = state.copyWith(email: value);
  void setPassword(String value) => state = state.copyWith(password: value);

  /// Runs local validation, then (if valid) calls Firebase sign-in.
  /// Returns true only on full success.
  Future<bool> submit() async {
    final emailError =
        state.email.contains('@') ? null : 'Enter a valid email address';
    final passwordError =
        state.password.length >= 6 ? null : 'Password must be 6+ characters';

    state = state.copyWith(emailError: emailError, passwordError: passwordError);
    if (emailError != null || passwordError != null) return false;

    final authError = await ref.read(authViewModelProvider.notifier).signIn(
          email: state.email,
          password: state.password,
        );

    if (authError != null) {
      state = state.copyWith(authError: authError);
      return false;
    }
    return true;
  }
}

final signInProvider =
    NotifierProvider<SignInViewModel, SignInState>(SignInViewModel.new);