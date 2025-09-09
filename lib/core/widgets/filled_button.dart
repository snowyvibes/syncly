import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.text,
    this.onPressed,
    this.height,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: width,
    child: FilledButton(
      onPressed: onPressed,
      child: Text(text),
    ),
  );
}
