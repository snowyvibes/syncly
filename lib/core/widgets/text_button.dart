import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final bool isLoading;

  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) => isLoading
      ? SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).primaryColor,
            ),
          ),
        )
      : TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: color ?? Colors.transparent,
          ),
          child: Text(text),
        );
}
