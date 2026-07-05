import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../widgets/neo_widgets.dart';
import 'sign_up_view_model.dart';

/// Sign Up: name + email + password, Create Account CTA, link to Sign In.
class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpProvider);
    final vm = ref.read(signUpProvider.notifier);

    return Scaffold(
      body: DottedBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
            children: [
              Text('Create account', style: AppText.display),
              const SizedBox(height: 8),
              Text('Start turning your fridge into dinner.',
                  style: AppText.body),
              const SizedBox(height: 32),
              NeoTextField(
                label: 'Name',
                hint: 'Alex Rivera',
                prefixIcon: Icons.person_outline,
                errorText: state.nameError,
                onChanged: vm.setName,
              ),
              const SizedBox(height: 20),
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
                label: 'Create Account',
                variant: NeoButtonVariant.secondary,
                onPressed: () {
                  if (vm.submit()) {
                    context.go('/home');
                  }
                },
              ),
              const SizedBox(height: 24),
              _SignInLink(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account? ', style: AppText.body),
        GestureDetector(
          onTap: () => context.go('/signin'),
          child: Text('Sign in',
              style: AppText.bodyBold.copyWith(
                decoration: TextDecoration.underline,
                color: AppColors.coral,
              )),
        ),
      ],
    );
  }
}
