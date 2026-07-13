import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../widgets/neo_widgets.dart';
import '../../viewmodels/sign_in_view_model.dart';

/// Sign In: email + password, Sign In CTA, link to Sign Up. Mock validation.
class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInProvider);
    final vm = ref.read(signInProvider.notifier);

    return Scaffold(
      body: DottedBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
            children: [
              Text('Welcome back', style: AppText.display),
              const SizedBox(height: 8),
              Text('Sign in to keep cooking with what you have.',
                  style: AppText.body),
              const SizedBox(height: 32),
              NeoTextField(
                label: 'Email',
                hint: 'you@fridgenius.app',
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
                errorText: state.emailError,
                onChanged: vm.setEmail,
              ),
              const SizedBox(height: 20),
              NeoTextField(
                label: 'Password',
                hint: '••••••',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                errorText: state.passwordError,
                onChanged: vm.setPassword,
              ),
              const SizedBox(height: 32),
              NeoButton(
                label: 'Sign In',
                onPressed: () {
                  if (vm.submit()) {
                    context.go('/home');
                  }
                },
              ),
              const SizedBox(height: 24),
              _SignUpLink(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("New here? ", style: AppText.body),
        GestureDetector(
          onTap: () => context.go('/signup'),
          child: Text('Create an account',
              style: AppText.bodyBold.copyWith(
                decoration: TextDecoration.underline,
                color: AppColors.coral,
              )),
        ),
      ],
    );
  }
}
