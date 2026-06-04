import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const Color _primary = Color(0xFF2563EB);
  static const Color _secondary = Color(0xFF0F766E);
  static const Color _surface = Color(0xFFF8FAFC);
  static const Color _darkSurface = Color(0xFF101828);

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primary,
      secondary: _secondary,
      surface: _surface,
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: _surface,
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primary,
      secondary: _secondary,
      surface: _darkSurface,
      brightness: Brightness.dark,
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B1220),
    );
  }

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
