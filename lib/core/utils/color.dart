import 'package:flutter/material.dart';

extension ColorUtils on Color {
  /// Returns true if the color is considered light
  bool get isLight => computeLuminance() > 0.5;

  /// Returns a contrasting text color (black for light backgrounds, white for dark)
  Color get contrastingTextColor => isLight ? Colors.black : Colors.white;

  /// Returns a contrasting color with custom light/dark colors
  Color contrastingColor({Color light = Colors.black, Color dark = Colors.white}) =>
      isLight ? light : dark;
}
