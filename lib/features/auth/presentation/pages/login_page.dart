import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/filled_button.dart';
import 'package:syncly/core/widgets/text_button.dart';
import 'package:syncly/core/widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
                'Welcome Back!',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomTextField(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
              ),
              const CustomTextField(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    text: 'Forgot Password?',
                    color: Theme.of(context).colorScheme.surface,
                    onPressed: () {},
                  ),
                ],
              ),
              CustomFilledButton(
                height: 50,
                width: 200,
                text: 'Login',
                onPressed: () {
                  context.go('/home');
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                  CustomTextButton(
                    text: 'Register',
                    color: Theme.of(context).colorScheme.surface,
                    onPressed: () {
                      context.go('/register');
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
