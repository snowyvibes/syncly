import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/filled_button.dart';
import 'package:syncly/core/widgets/text_button.dart';
import 'package:syncly/core/widgets/text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.padding * 2),

            child: Column(
              spacing: AppSizes.columnSpacing,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Let\'s Get Started!',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(color: surfaceColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: surfaceColor),
                ),
                CustomTextField(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: surfaceColor),
                ),
                CustomTextField(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: surfaceColor),
                ),
                CustomTextField(
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: surfaceColor),
                ),
                const SizedBox(
                  height: 20,
                ),

                CustomFilledButton(
                  height: 50,
                  width: 200,
                  text: 'Register',

                  onPressed: () {
                    context.go('/home');
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: surfaceColor),
                    ),
                    CustomTextButton(
                      text: 'Login',
                      textColor: surfaceColor,
                      onPressed: () {
                        context.go('/login');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
