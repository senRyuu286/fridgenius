import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Immutable state for the Sign In form.
class SignInState {
  const SignInState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
  });

  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
}

/// ViewModel for Sign In. Mock validation only — no live auth.
class SignInViewModel extends Notifier<SignInState> {
  @override
  SignInState build() => const SignInState();

  void setEmail(String value) =>
      state = SignInState(email: value, password: state.password);

  void setPassword(String value) =>
      state = SignInState(email: state.email, password: value);

  /// Runs mock validation, updates error state, and returns whether the form
  /// is valid. TODO(backend): replace with FirebaseAuth sign-in.
  bool submit() {
    final emailError =
        state.email.contains('@') ? null : 'Enter a valid email address';
    final passwordError =
        state.password.length >= 6 ? null : 'Password must be 6+ characters';
    state = SignInState(
      email: state.email,
      password: state.password,
      emailError: emailError,
      passwordError: passwordError,
    );
    return emailError == null && passwordError == null;
  }
}

final signInProvider =
    NotifierProvider<SignInViewModel, SignInState>(SignInViewModel.new);
