import 'package:flutter/material.dart';

const _primaryColor = Color(0xFF0B4F6C);
const _secondaryColor = Color(0xFF59A5D8);
const _tertiaryColor = Color(0xFFFAF4D3);

const _elevationOverlayColor = Colors.transparent;

const _brandGradient = LinearGradient(
  colors: [Color(0xFF4B5FFF), Color(0xFF7F53FF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

TextTheme _typography(ColorScheme scheme, bool dark) {
  const display = 'Zain';
  const text = 'Zain';
  return const TextTheme(
    displayLarge: TextStyle(
      fontFamily: display,
      fontWeight: FontWeight.w100,
      letterSpacing: -1.5,
      fontSize: 72,
    ),
    displayMedium: TextStyle(
      fontFamily: display,
      fontWeight: FontWeight.w100,
      letterSpacing: -1.2,
      fontSize: 60,
    ),
    displaySmall: TextStyle(
      fontFamily: display,
      fontWeight: FontWeight.w200,
      letterSpacing: -1.0,
      fontSize: 48,
    ),
    headlineLarge: TextStyle(
      fontFamily: display,
      fontWeight: FontWeight.w200,
      letterSpacing: -1.0,
      fontSize: 42,
    ),
    headlineMedium: TextStyle(
      fontFamily: display,
      fontWeight: FontWeight.w200,
      letterSpacing: -0.8,
      fontSize: 36,
    ),
    headlineSmall: TextStyle(
      fontFamily: display,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.6,
      fontSize: 32,
    ),
    titleLarge: TextStyle(
      fontFamily: text,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.4,
      fontSize: 28,
    ),
    titleMedium: TextStyle(
      fontFamily: text,
      fontWeight: FontWeight.w300,
      fontSize: 24,
      letterSpacing: 0,
    ),
    titleSmall: TextStyle(
      fontFamily: text,
      fontWeight: FontWeight.w300,
      fontSize: 22,
      letterSpacing: 0,
    ),
    bodyLarge: TextStyle(fontFamily: text, fontWeight: FontWeight.w200, fontSize: 24),
    bodyMedium: TextStyle(fontFamily: text, fontWeight: FontWeight.w200, fontSize: 22),
    bodySmall: TextStyle(fontFamily: text, fontWeight: FontWeight.w200, fontSize: 18),
    labelLarge: TextStyle(
      fontFamily: text,
      fontWeight: FontWeight.w300,
      fontSize: 18,
      letterSpacing: 0.2,
    ),
    labelMedium: TextStyle(
      fontFamily: text,
      fontWeight: FontWeight.w300,
      fontSize: 16,
      letterSpacing: 0.2,
    ),
    labelSmall: TextStyle(
      fontFamily: text,
      fontWeight: FontWeight.w300,
      fontSize: 14,
      letterSpacing: 0.4,
    ),
  ).apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
}

final ColorScheme _lightScheme = ColorScheme.fromSeed(
  seedColor: _primaryColor,
  secondary: _secondaryColor,
  tertiary: _tertiaryColor,
  surface: const Color(0xFFF8F9FC),
  surfaceContainerHighest: const Color(0xFFE5E7F2),
);

final ColorScheme _darkScheme = ColorScheme.fromSeed(
  seedColor: _primaryColor,
  secondary: _secondaryColor,
  tertiary: _tertiaryColor,
  brightness: Brightness.dark,
  surface: const Color(0xFF11131A),
  surfaceContainerHighest: const Color(0xFF1E2330),
);

ShapeBorder _cardShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));

InputBorder _inputBorder(Color color) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(14),
  borderSide: BorderSide(color: color),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _lightScheme,
  brightness: Brightness.light,
  fontFamily: 'Zain',
  splashFactory: InkSparkle.splashFactory,
  scaffoldBackgroundColor: _lightScheme.surface,
  typography: Typography.material2021(),
  textTheme: _typography(_lightScheme, false),
  appBarTheme: AppBarTheme(
    backgroundColor: _lightScheme.surface.withOpacity(0.9),
    elevation: 0,
    scrolledUnderElevation: 4,
    surfaceTintColor: Colors.transparent,
    foregroundColor: _lightScheme.onSurface,
    centerTitle: true,
    titleTextStyle: _typography(_lightScheme, false).titleLarge,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: _lightScheme.surface,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    indicatorColor: _lightScheme.primary.withOpacity(.14),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    color: _lightScheme.surface,
    surfaceTintColor: Colors.transparent,
    shape: _cardShape,
    clipBehavior: Clip.antiAlias,
    margin: const EdgeInsets.all(12),
  ),
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    backgroundColor: _lightScheme.surface,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: _lightScheme.surface,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
  ),
  iconTheme: IconThemeData(color: _lightScheme.onSurfaceVariant),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 28, vertical: 18)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.disabled)
            ? _lightScheme.primary.withOpacity(.25)
            : _lightScheme.primary,
      ),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(.08)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      foregroundColor: WidgetStateProperty.all(_lightScheme.primary),
      overlayColor: WidgetStateProperty.all(_lightScheme.primary.withOpacity(.08)),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      side: WidgetStateProperty.resolveWith(
        (s) => BorderSide(
          color: s.contains(WidgetState.disabled)
              ? _lightScheme.outlineVariant
              : _lightScheme.primary,
          width: 1.2,
        ),
      ),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
      foregroundColor: WidgetStateProperty.all(_lightScheme.primary),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: _lightScheme.outlineVariant.withOpacity(.4),
    thickness: 1,
    space: 40,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _lightScheme.surfaceVariant.withOpacity(.35),
    hintStyle: TextStyle(color: _lightScheme.onSurfaceVariant.withOpacity(.6)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    enabledBorder: _inputBorder(Colors.transparent),
    focusedBorder: _inputBorder(_lightScheme.primary),
    errorBorder: _inputBorder(_lightScheme.error),
    focusedErrorBorder: _inputBorder(_lightScheme.error),
    border: _inputBorder(Colors.transparent),
  ),
  chipTheme: ChipThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    backgroundColor: _lightScheme.surfaceVariant.withOpacity(.5),
    selectedColor: _lightScheme.primary.withOpacity(.18),
    labelStyle: TextStyle(color: _lightScheme.onSurface),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 4,
    inactiveTrackColor: _lightScheme.primary.withOpacity(.15),
    activeTrackColor: _lightScheme.primary,
    thumbColor: _lightScheme.primary,
    overlayColor: _lightScheme.primary.withOpacity(.12),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: _lightScheme.primary,
    linearTrackColor: _lightScheme.primary.withOpacity(.15),
  ),
  extensions: <ThemeExtension<dynamic>>[const _BrandingExtension(gradient: _brandGradient)],
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _darkScheme,
  brightness: Brightness.dark,
  fontFamily: 'Zain',
  splashFactory: InkSparkle.splashFactory,
  scaffoldBackgroundColor: _darkScheme.surface,
  typography: Typography.material2021(),
  textTheme: _typography(_darkScheme, true),
  appBarTheme: AppBarTheme(
    backgroundColor: _darkScheme.surface.withOpacity(0.92),
    elevation: 0,
    scrolledUnderElevation: 4,
    surfaceTintColor: Colors.transparent,
    foregroundColor: _darkScheme.onSurface,
    centerTitle: true,
    titleTextStyle: _typography(_darkScheme, true).titleLarge,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: _darkScheme.surface,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    indicatorColor: _darkScheme.primary.withOpacity(.22),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    color: _darkScheme.surface,
    surfaceTintColor: Colors.transparent,
    shape: _cardShape,
    clipBehavior: Clip.antiAlias,
    margin: const EdgeInsets.all(12),
  ),
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    backgroundColor: _darkScheme.surface,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: _darkScheme.surface,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
  ),
  iconTheme: IconThemeData(color: _darkScheme.onSurfaceVariant),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 28, vertical: 18)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.disabled)
            ? _darkScheme.primary.withOpacity(.25)
            : _darkScheme.primary,
      ),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(.10)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      foregroundColor: WidgetStateProperty.all(_darkScheme.primary),
      overlayColor: WidgetStateProperty.all(_darkScheme.primary.withOpacity(.16)),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      side: WidgetStateProperty.resolveWith(
        (s) => BorderSide(
          color: s.contains(WidgetState.disabled)
              ? _darkScheme.outlineVariant
              : _darkScheme.primary,
          width: 1.2,
        ),
      ),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
      foregroundColor: WidgetStateProperty.all(_darkScheme.primary),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: _darkScheme.outlineVariant.withOpacity(.5),
    thickness: 1,
    space: 40,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _darkScheme.surfaceVariant.withOpacity(.35),
    hintStyle: TextStyle(color: _darkScheme.onSurfaceVariant.withOpacity(.6)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    enabledBorder: _inputBorder(Colors.transparent),
    focusedBorder: _inputBorder(_darkScheme.primary),
    errorBorder: _inputBorder(_darkScheme.error),
    focusedErrorBorder: _inputBorder(_darkScheme.error),
    border: _inputBorder(Colors.transparent),
  ),
  chipTheme: ChipThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    backgroundColor: _darkScheme.surfaceVariant.withOpacity(.4),
    selectedColor: _darkScheme.primary.withOpacity(.28),
    labelStyle: TextStyle(color: _darkScheme.onSurface),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 4,
    inactiveTrackColor: _darkScheme.primary.withOpacity(.25),
    activeTrackColor: _darkScheme.primary,
    thumbColor: _darkScheme.primary,
    overlayColor: _darkScheme.primary.withOpacity(.18),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: _darkScheme.primary,
    linearTrackColor: _darkScheme.primary.withOpacity(.18),
  ),
  extensions: const <ThemeExtension<dynamic>>[_BrandingExtension(gradient: _brandGradient)],
);

// Custom ThemeExtension for brand extras (e.g., gradient usage)
@immutable
class _BrandingExtension extends ThemeExtension<_BrandingExtension> {
  final Gradient gradient;
  const _BrandingExtension({required this.gradient});

  @override
  _BrandingExtension copyWith({Gradient? gradient}) =>
      _BrandingExtension(gradient: gradient ?? this.gradient);

  @override
  _BrandingExtension lerp(ThemeExtension<_BrandingExtension>? other, double t) {
    if (other is! _BrandingExtension) return this;
    return _BrandingExtension(
      gradient:
          LinearGradient.lerp(gradient as LinearGradient, other.gradient as LinearGradient, t) ??
          gradient,
    );
  }
}
