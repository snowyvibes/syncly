import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final double? elevation;
  final bool isLoading;

  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.elevation = 0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) => Material(
    elevation: elevation ?? 0,
    borderRadius: BorderRadius.circular(AppSizes.borderRadius),
    color: backgroundColor ?? Colors.transparent,
    child: InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : Text(
                  text,

                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: textColor,
                    color: textColor ?? Theme.of(context).primaryColor,
                  ),
                ),
        ),
      ),
    ),
  );
}
