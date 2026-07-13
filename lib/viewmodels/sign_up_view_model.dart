import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Immutable state for the Sign Up form.
class SignUpState {
  const SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.nameError,
    this.emailError,
    this.passwordError,
  });

  final String name;
  final String email;
  final String password;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
}

/// ViewModel for Sign Up. Mock validation only — no live auth.
class SignUpViewModel extends Notifier<SignUpState> {
  @override
  SignUpState build() => const SignUpState();

  void setName(String value) => state = SignUpState(
        name: value,
        email: state.email,
        password: state.password,
      );

  void setEmail(String value) => state = SignUpState(
        name: state.name,
        email: value,
        password: state.password,
      );

  void setPassword(String value) => state = SignUpState(
        name: state.name,
        email: state.email,
        password: value,
      );

  /// Runs mock validation, updates error state, and returns whether the form
  /// is valid. TODO(backend): replace with FirebaseAuth account creation.
  bool submit() {
    final nameError =
        state.name.trim().isNotEmpty ? null : 'Please enter your name';
    final emailError =
        state.email.contains('@') ? null : 'Enter a valid email address';
    final passwordError =
        state.password.length >= 6 ? null : 'Password must be 6+ characters';
    state = SignUpState(
      name: state.name,
      email: state.email,
      password: state.password,
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
    );
    return nameError == null && emailError == null && passwordError == null;
  }
}

final signUpProvider =
    NotifierProvider<SignUpViewModel, SignUpState>(SignUpViewModel.new);
