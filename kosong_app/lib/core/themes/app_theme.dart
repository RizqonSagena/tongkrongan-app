import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // PRIMARY COLORS
  static const Color primary = Color(0xFFa33900);
  static const Color primaryContainer = Color(0xFFca4b07);
  static const Color primaryFixed = Color(0xFFffdbce);
  static const Color primaryFixedDim = Color(0xFFffb599);
  static const Color onPrimary = Color(0xFFffffff);
  static const Color onPrimaryFixed = Color(0xFF370e00);
  static const Color onPrimaryFixedVariant = Color(0xFF7f2b00);
  static const Color onPrimaryContainer = Color(0xFFfffbff);
  
  // SECONDARY COLORS
  static const Color secondary = Color(0xFF875200);
  static const Color secondaryContainer = Color(0xFFfdb257);
  static const Color secondaryFixed = Color(0xFFffddba);
  static const Color secondaryFixedDim = Color(0xFFffb866);
  static const Color onSecondary = Color(0xFFffffff);
  static const Color onSecondaryFixed = Color(0xFF2b1700);
  static const Color onSecondaryFixedVariant = Color(0xFF673d00);
  static const Color onSecondaryContainer = Color(0xFF724400);
  
  // TERTIARY COLORS (Active/Success States)
  static const Color tertiary = Color(0xFF006857);
  static const Color tertiaryContainer = Color(0xFF28826f);
  static const Color tertiaryFixed = Color(0xFF9df3db);
  static const Color tertiaryFixedDim = Color(0xFF81d6c0);
  static const Color onTertiary = Color(0xFFffffff);
  static const Color onTertiaryFixed = Color(0xFF002019);
  static const Color onTertiaryFixedVariant = Color(0xFF005143);
  static const Color onTertiaryContainer = Color(0xFFf4fffa);
  
  // SURFACE COLORS
  static const Color surface = Color(0xFFfbf8ff);
  static const Color surfaceContainer = Color(0xFFefecf5);
  static const Color surfaceContainerLowest = Color(0xFFffffff);
  static const Color surfaceContainerLow = Color(0xFFf5f2fb);
  static const Color surfaceContainerHigh = Color(0xFFeae7ef);
  static const Color surfaceContainerHighest = Color(0xFFe4e1ea);
  static const Color surfaceVariant = Color(0xFFe4e1ea);
  static const Color surfaceTint = primary;
  static const Color surfaceDim = Color(0xFFdbd9e1);
  static const Color surfaceBright = Color(0xFFfbf8ff);
  
  // TEXT/ON SURFACE COLORS
  static const Color onSurface = Color(0xFF1b1b21);
  static const Color onSurfaceVariant = Color(0xFF594139);
  
  // OUTLINE & BORDERS
  static const Color outline = Color(0xFF8d7167);
  static const Color outlineVariant = Color(0xFFe1bfb4);
  
  // ERROR COLORS
  static const Color error = Color(0xFFba1a1a);
  static const Color errorContainer = Color(0xFFffdad6);
  static const Color onError = Color(0xFFffffff);
  static const Color onErrorContainer = Color(0xFF93000a);
  
  // INVERSE COLORS (for dark surfaces)
  static const Color inverseSurface = Color(0xFF303036);
  static const Color inverseOnSurface = Color(0xFFf2eff8);
  static const Color inversePrimary = Color(0xFFffb599);
  
  static const Color backgroundLight = Color(0xFFfbf8ff);

  // SPACING SYSTEM (Tailwind-like)
  static const double spaceXs = 4.0;    // 0.25rem
  static const double spaceSm = 8.0;    // 0.5rem
  static const double spaceMd = 16.0;   // 1rem
  static const double spaceLg = 24.0;   // 1.5rem
  static const double spaceXl = 32.0;   // 2rem
  static const double margin = 20.0;    // 1.25rem (px-margin)
  static const double gutter = 16.0;    // 1rem
  
  // BORDER RADIUS SYSTEM
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 18.0;   // Custom card radius
  static const double radiusFull = 9999; // Pill buttons
  
  // SHADOW SYSTEM (custom Material Design 3)
  static const BoxShadow shadowSm = BoxShadow(
    color: Color(0x0d6e3c14),  // rgba(110,60,20,0.05)
    blurRadius: 2,
    offset: Offset(0, 1),
  );
  
  static const BoxShadow shadowMd = BoxShadow(
    color: Color(0x196e3c14),  // rgba(110,60,20,0.1)
    blurRadius: 4,
    offset: Offset(0, 2),
  );
  
  static const BoxShadow shadowLg = BoxShadow(
    color: Color(0x266e3c14),   // rgba(110,60,20,0.15)
    blurRadius: 20,
    offset: Offset(-2, 4),
  );
  
  static const List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Color(0x0d6e3c14),
      blurRadius: 20,
      offset: Offset(-2, 4),
    ),
    BoxShadow(
      color: Color(0x0d6e3c14),
      blurRadius: 6,
      offset: Offset(-1, 2),
    ),
  ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        surface: surface,
        error: error,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onTertiary: onTertiary,
        onSurface: onSurface,
        onError: onError,
        outline: outline,
        outlineVariant: outlineVariant,
        surfaceContainer: surfaceContainer,
        onSurfaceVariant: onSurfaceVariant,
        inverseSurface: Color(0xFF303036),
        onInverseSurface: Color(0xFFf2eff8),
        inversePrimary: primaryFixedDim,
        surfaceTint: primary,
      ),
      scaffoldBackgroundColor: backgroundLight,
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: surface.withValues(alpha: 0.85),  // Backdrop blur effect
        foregroundColor: onSurface,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: const TextStyle(
          color: onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        shadowColor: Colors.black.withValues(alpha: 0.03),
      ),
      cardTheme: CardThemeData(
        color: surfaceContainerLowest,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: primary, width: 0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        isDense: false,
        hintStyle: TextStyle(
          color: outline,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          color: onSurfaceVariant,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: onSurface,
        ),
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: onSurface,
          letterSpacing: 0.4,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceContainer,
        selectedColor: primaryFixed,
        disabledColor: surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        elevation: 4,
      ),
      dividerTheme: DividerThemeData(
        color: outlineVariant,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(
        color: onSurface,
        size: 24,
      ),
    );
  }
}