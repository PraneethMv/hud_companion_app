import 'package:flutter/material.dart';

class CompanionTheme {
  final Color surface;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;

  final Color onSurface;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  final Color secondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;

  final Color error;
  final Color errorContainer;
  final Color onErrorContainer;

  final Color statusOk;
  final Color statusWarning;
  final Color cardBorder;
  final List<BoxShadow> glow;

  const CompanionTheme({
    required this.surface,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.error,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.statusOk,
    required this.statusWarning,
    required this.cardBorder,
    required this.glow,
  });

  /// Dark automotive obsidian palette (Default)
  static const dark = CompanionTheme(
    surface: Color(0xFF0C0E12),
    surfaceContainerLowest: Color(0xFF07080A),
    surfaceContainerLow: Color(0xFF12151B),
    surfaceContainer: Color(0xFF181B23),
    surfaceContainerHigh: Color(0xFF222631),
    surfaceContainerHighest: Color(0xFF2D3240),
    onSurface: Color(0xFFF3F4F6),
    onSurfaceVariant: Color(0xFF9CA3AF),
    outline: Color(0xFF4B5563),
    outlineVariant: Color(0xFF2C3240),
    primary: Color(0xFF00E5A0),
    onPrimary: Color(0xFF003824),
    primaryContainer: Color(0xFF004D32),
    onPrimaryContainer: Color(0xFF89F8C7),
    secondary: Color(0xFF94A3B8),
    secondaryContainer: Color(0xFF334155),
    onSecondaryContainer: Color(0xFFE2E8F0),
    error: Color(0xFFFF5252),
    errorContainer: Color(0xFF5C0000),
    onErrorContainer: Color(0xFFFFDAD6),
    statusOk: Color(0xFF00E5A0),
    statusWarning: Color(0xFFFFB951),
    cardBorder: Color(0x1FFFFFFF),
    glow: [
      BoxShadow(
        color: Color(0x3300E5A0),
        blurRadius: 16,
        offset: Offset(0, 4),
      ),
    ],
  );

  /// Light daytime palette
  static const light = CompanionTheme(
    surface: Color(0xFFF7F8FC),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFEEF0F6),
    surfaceContainer: Color(0xFFE5E8F0),
    surfaceContainerHigh: Color(0xFFDBDFEA),
    surfaceContainerHighest: Color(0xFFD0D5E2),
    onSurface: Color(0xFF111827),
    onSurfaceVariant: Color(0xFF4B5563),
    outline: Color(0xFF9CA3AF),
    outlineVariant: Color(0xFFCBD5E1),
    primary: Color(0xFF00A870),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFC7F9E5),
    onPrimaryContainer: Color(0xFF003824),
    secondary: Color(0xFF475569),
    secondaryContainer: Color(0xFFE2E8F0),
    onSecondaryContainer: Color(0xFF0F172A),
    error: Color(0xFFDC2626),
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF7F1D1D),
    statusOk: Color(0xFF00A870),
    statusWarning: Color(0xFFD97706),
    cardBorder: Color(0x14000000),
    glow: [
      BoxShadow(
        color: Color(0x1A00A870),
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ],
  );

  CompanionTheme withAccent(String colorSeed, {bool isDark = true}) {
    Color newPrimary;
    Color newOnPrimary;
    Color newPrimaryContainer;
    Color newOnPrimaryContainer;
    List<BoxShadow> newGlow;

    if (isDark) {
      switch (colorSeed) {
        case 'amber':
          newPrimary = const Color(0xFFFFB951);
          newOnPrimary = const Color(0xFF452B00);
          newPrimaryContainer = const Color(0xFF633F00);
          newOnPrimaryContainer = const Color(0xFFFFDDB3);
          newGlow = const [
            BoxShadow(color: Color(0x33FFB951), blurRadius: 16, offset: Offset(0, 4))
          ];
          break;
        case 'blue':
          newPrimary = const Color(0xFF60A5FA);
          newOnPrimary = const Color(0xFF0B2D6B);
          newPrimaryContainer = const Color(0xFF1D4ED8);
          newOnPrimaryContainer = const Color(0xFFDBEAFE);
          newGlow = const [
            BoxShadow(color: Color(0x3360A5FA), blurRadius: 16, offset: Offset(0, 4))
          ];
          break;
        case 'purple':
          newPrimary = const Color(0xFFC084FC);
          newOnPrimary = const Color(0xFF381E72);
          newPrimaryContainer = const Color(0xFF581C87);
          newOnPrimaryContainer = const Color(0xFFF3E8FF);
          newGlow = const [
            BoxShadow(color: Color(0x33C084FC), blurRadius: 16, offset: Offset(0, 4))
          ];
          break;
        case 'emerald':
        default:
          return this;
      }
    } else {
      switch (colorSeed) {
        case 'amber':
          newPrimary = const Color(0xFFD97706);
          newOnPrimary = Colors.white;
          newPrimaryContainer = const Color(0xFFFEF3C7);
          newOnPrimaryContainer = const Color(0xFF78350F);
          newGlow = const [
            BoxShadow(color: Color(0x1AD97706), blurRadius: 12, offset: Offset(0, 4))
          ];
          break;
        case 'blue':
          newPrimary = const Color(0xFF2563EB);
          newOnPrimary = Colors.white;
          newPrimaryContainer = const Color(0xFFDBEAFE);
          newOnPrimaryContainer = const Color(0xFF1E3A8A);
          newGlow = const [
            BoxShadow(color: Color(0x1A2563EB), blurRadius: 12, offset: Offset(0, 4))
          ];
          break;
        case 'purple':
          newPrimary = const Color(0xFF9333EA);
          newOnPrimary = Colors.white;
          newPrimaryContainer = const Color(0xFFF3E8FF);
          newOnPrimaryContainer = const Color(0xFF581C87);
          newGlow = const [
            BoxShadow(color: Color(0x1A9333EA), blurRadius: 12, offset: Offset(0, 4))
          ];
          break;
        case 'emerald':
        default:
          return this;
      }
    }

    return CompanionTheme(
      surface: surface,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      primary: newPrimary,
      onPrimary: newOnPrimary,
      primaryContainer: newPrimaryContainer,
      onPrimaryContainer: newOnPrimaryContainer,
      secondary: secondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      error: error,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      statusOk: statusOk,
      statusWarning: statusWarning,
      cardBorder: cardBorder,
      glow: newGlow,
    );
  }

  ThemeData toThemeData({required bool isDark}) {
    final colorScheme = ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: Colors.white,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: onSurface,
      outline: outline,
      outlineVariant: outlineVariant,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: surface,
      colorScheme: colorScheme,
      cardColor: surfaceContainer,
      dividerColor: outlineVariant,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: onSurface,
      ),
    );
  }
}

