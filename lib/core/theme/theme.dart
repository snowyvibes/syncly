import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';

const _primaryColor = Color(0xFF023436);
const _secondaryColor = Color(0xFF8AB0AB);
const _tertiaryColor = Color(0xFFFAF4D3);

// const _primaryColor = Color(0xFF0B4F6C);
// const _secondaryColor = Color(0xFF59A5D8);
// const _tertiaryColor = Color(0xFFFAF4D3);

// const _elevationOverlayColor = Colors.transparent;

const _brandGradient = LinearGradient(
  colors: [Color(0xFF4B5FFF), Color(0xFF7F53FF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

TextTheme _typography(ColorScheme scheme, bool dark) {
  const _fontStartSize = 18.0;
  const _displayFontStartSize = _fontStartSize + 6.0;

  const display = 'Zain';
  const text = 'Zain';
  return const TextTheme(
    displayLarge: TextStyle(
      fontFamily: display,

      letterSpacing: -1.5,
      fontSize: _displayFontStartSize + 24,
    ),
    displayMedium: TextStyle(
      fontFamily: display,
      letterSpacing: -1.2,
      fontSize: _displayFontStartSize + 20,
    ),
    displaySmall: TextStyle(
      fontFamily: display,
      letterSpacing: -1.0,
      fontSize: _displayFontStartSize + 18,
    ),
    headlineLarge: TextStyle(
      fontFamily: display,

      letterSpacing: -1.0,
      fontSize: _displayFontStartSize + 16,
    ),
    headlineMedium: TextStyle(
      fontFamily: display,

      letterSpacing: -0.8,
      fontSize: _displayFontStartSize + 14,
    ),
    headlineSmall: TextStyle(
      fontFamily: display,

      letterSpacing: -0.6,
      fontSize: _displayFontStartSize + 12,
    ),
    titleLarge: TextStyle(
      fontFamily: display,

      letterSpacing: -0.4,
      fontSize: _fontStartSize + 10,
    ),
    titleMedium: TextStyle(
      fontFamily: display,

      fontSize: _fontStartSize + 8,
      letterSpacing: 0,
    ),
    titleSmall: TextStyle(
      fontFamily: display,

      fontSize: _fontStartSize + 6,
      letterSpacing: 0,
    ),
    bodyLarge: TextStyle(
      fontFamily: text,

      fontSize: _fontStartSize + 4,
    ),
    bodyMedium: TextStyle(
      fontFamily: text,
      fontSize: _fontStartSize + 2,
    ),
    bodySmall: TextStyle(
      fontFamily: text,
      fontSize: _fontStartSize,
    ),
    labelLarge: TextStyle(
      fontFamily: text,

      fontSize: _fontStartSize + 4,
      letterSpacing: 0.2,
    ),
    labelMedium: TextStyle(
      fontFamily: text,

      fontSize: _fontStartSize + 2,
      letterSpacing: 0.2,
    ),
    labelSmall: TextStyle(
      fontFamily: text,

      fontSize: _fontStartSize,
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

ShapeBorder _cardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(AppSizes.borderRadius),
);

InputBorder _inputBorder(Color color) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(AppSizes.borderRadius),
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
    backgroundColor: _lightScheme.primary,
    elevation: 0,
    scrolledUnderElevation: 4,
    surfaceTintColor: Colors.transparent,
    foregroundColor: _lightScheme.surface,
    centerTitle: true,
    titleTextStyle: _typography(
      _lightScheme,
      false,
    ).titleLarge!.copyWith(color: _lightScheme.surface),
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
    backgroundColor: _lightScheme.surface,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: _lightScheme.surface,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadius)),
    ),
  ),
  iconTheme: IconThemeData(color: _lightScheme.onSurfaceVariant),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
      ),
      side: WidgetStateProperty.resolveWith(
        (s) => BorderSide(
          color: s.contains(WidgetState.disabled)
              ? _lightScheme.outlineVariant
              : _lightScheme.primary,
          width: 1.2,
        ),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: AppSizes.padding * 2, vertical: AppSizes.padding),
      ),
      foregroundColor: WidgetStateProperty.all(_lightScheme.primary),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: AppSizes.padding * 2, vertical: AppSizes.padding),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
      ),
      elevation: WidgetStateProperty.all(AppSizes.elevation),
      backgroundColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.disabled)
            ? _lightScheme.primary.withOpacity(.25)
            : _lightScheme.primary,
      ),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(.08)),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: AppSizes.padding * 2, vertical: AppSizes.padding),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
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
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
      ),
      foregroundColor: WidgetStateProperty.all(_lightScheme.primary),
      overlayColor: WidgetStateProperty.all(_lightScheme.primary.withOpacity(.08)),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: AppSizes.padding * 2, vertical: AppSizes.padding),
      ),
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
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSizes.padding * 2,
      vertical: AppSizes.padding,
    ),
    enabledBorder: _inputBorder(Colors.transparent),
    focusedBorder: _inputBorder(_lightScheme.primary),
    errorBorder: _inputBorder(_lightScheme.error),
    focusedErrorBorder: _inputBorder(_lightScheme.error),
    border: _inputBorder(Colors.transparent),
  ),
  chipTheme: ChipThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius / 2)),
    checkmarkColor: _lightScheme.primary,
    backgroundColor: _lightScheme.surfaceContainer,
    selectedColor: _lightScheme.primary,
    labelStyle: TextStyle(color: _lightScheme.onSurface),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.padding,
      vertical: AppSizes.padding / 2,
    ),
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
    backgroundColor: _darkScheme.primary,
    elevation: 0,
    scrolledUnderElevation: 4,
    surfaceTintColor: Colors.transparent,
    foregroundColor: _darkScheme.surface,
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
    backgroundColor: _darkScheme.surface,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: _darkScheme.surface,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadius)),
    ),
  ),
  iconTheme: IconThemeData(color: _darkScheme.onSurfaceVariant),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: AppSizes.padding * 2, vertical: AppSizes.padding),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
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
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
      ),
      foregroundColor: WidgetStateProperty.all(_darkScheme.primary),
      overlayColor: WidgetStateProperty.all(_darkScheme.primary.withOpacity(.16)),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: AppSizes.padding * 2, vertical: AppSizes.padding),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
      ),
      side: WidgetStateProperty.resolveWith(
        (s) => BorderSide(
          color: s.contains(WidgetState.disabled)
              ? _darkScheme.outlineVariant
              : _darkScheme.primary,
          width: 1.2,
        ),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: AppSizes.padding * 2, vertical: AppSizes.padding),
      ),
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
    backgroundColor: _darkScheme.surfaceVariant.withOpacity(.4),
    selectedColor: _darkScheme.primary.withOpacity(.28),
    labelStyle: TextStyle(color: _darkScheme.onSurface),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.padding,
      vertical: AppSizes.padding / 2,
    ),
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
