import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'login_view_signup_links.dart';
import '../../state/auth/providers/auth_state_provider.dart';
import '../constants/app_colors.dart';
import '../constants/views_strings.dart';
import 'divider_with_margins.dart';
import 'facebook_button.dart';
import 'google_button.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  '${ViewsStrings.welcomeToAppName}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const DividerWithMargins(),
                Text(
                  '${ViewsStrings.logIntoYourAccount}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                    foregroundColor: AppColors.loginButtonTextColor,
                  ),
                  onPressed:
                      ref.read(authStateProvider.notifier).loginWithGoogle,
                  child: const GoogleButton(),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                    foregroundColor: AppColors.loginButtonTextColor,
                  ),
                  onPressed:
                      ref.read(authStateProvider.notifier).loginWithFacebook,
                  child: const FacebookButton(),
                ),
                const DividerWithMargins(),
                const LoginViewSignupLinks()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
