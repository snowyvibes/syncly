import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.height,
    this.width,
    this.color,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: width,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color ?? Theme.of(context).colorScheme.primary),
      ),
      child: Text(text, style: TextStyle(color: color ?? Theme.of(context).colorScheme.primary)),
    ),
  );
}
