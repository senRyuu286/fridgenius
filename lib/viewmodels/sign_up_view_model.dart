import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_view_model.dart';

/// Immutable state for the Sign Up form.
class SignUpState {
  const SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.nameError,
    this.emailError,
    this.passwordError,
    this.authError,
  });

  final String name;
  final String email;
  final String password;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? authError;

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? authError,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
      authError: authError,
    );
  }
}

/// ViewModel for Sign Up. Local field validation stays mock/instant;
/// account creation is delegated to AuthViewModel.
class SignUpViewModel extends Notifier<SignUpState> {
  @override
  SignUpState build() => const SignUpState();

  void setName(String value) => state = state.copyWith(name: value);
  void setEmail(String value) => state = state.copyWith(email: value);
  void setPassword(String value) => state = state.copyWith(password: value);

  Future<bool> submit() async {
    final nameError =
        state.name.trim().isNotEmpty ? null : 'Please enter a username';
    final emailError =
        state.email.contains('@') ? null : 'Enter a valid email address';
    final passwordError =
        state.password.length >= 6 ? null : 'Password must be 6+ characters';

    state = state.copyWith(
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
    );
    if (nameError != null || emailError != null || passwordError != null) {
      return false;
    }

    final authError = await ref.read(authViewModelProvider.notifier).signUp(
          name: state.name,
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

final signUpProvider =
    NotifierProvider<SignUpViewModel, SignUpState>(SignUpViewModel.new);