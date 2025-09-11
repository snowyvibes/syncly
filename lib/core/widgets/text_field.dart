import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextStyle? hintStyle;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool enabled;
  final int? maxLines;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.enabled = true,
    this.maxLines = 1,
    this.fillColor,
    this.borderColor,
    this.hintStyle,
    this.borderRadius = AppSizes.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      enabled: enabled,
      maxLines: maxLines,
      onEditingComplete: () => FocusScope.of(context).unfocus(),
      contextMenuBuilder: (context, editableTextState) {
        final TextEditingValue value = editableTextState.textEditingValue;
        final List<ContextMenuButtonItem> buttonItems = [
          if (editableTextState.widget.selectionEnabled && !value.selection.isCollapsed)
            ContextMenuButtonItem(
              label: 'Cut',
              onPressed: () {
                editableTextState.cutSelection(SelectionChangedCause.toolbar);
              },
            ),
          if (editableTextState.widget.selectionEnabled && !value.selection.isCollapsed)
            ContextMenuButtonItem(
              label: 'Copy',
              onPressed: () {
                editableTextState.copySelection(SelectionChangedCause.toolbar);
              },
            ),
          if (editableTextState.widget.selectionEnabled && !value.selection.isCollapsed)
            ContextMenuButtonItem(
              label: 'Paste',
              onPressed: () {
                editableTextState.pasteText(SelectionChangedCause.toolbar);
              },
            ),
          if (!enabled && value.text.isNotEmpty)
            ContextMenuButtonItem(
              label: 'Select All',
              onPressed: () {
                editableTextState.selectAll(SelectionChangedCause.toolbar);
              },
            ),
        ];
        return AdaptiveTextSelectionToolbar.buttonItems(
          anchors: editableTextState.contextMenuAnchors,
          buttonItems: buttonItems,
        );
      },
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintStyle,
        // filled: true,
        // fillColor: fillColor ?? theme.colorScheme.surface,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: theme.colorScheme.onSurfaceVariant)
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: theme.colorScheme.onSurfaceVariant),
                onPressed: onSuffixIconPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.outline.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.all(AppSizes.padding),
      ),
    );
  }
}
