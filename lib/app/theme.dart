import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class AppTheme {
  static ThemeData get light {
    return _build(colors: AppPalette.light, brightness: Brightness.light);
  }

  static ThemeData get dark {
    return _build(colors: AppPalette.dark, brightness: Brightness.dark);
  }

  static ThemeData _build({
    required AppPalette colors,
    required Brightness brightness,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: Colors.white,
      secondary: colors.link,
      onSecondary: Colors.white,
      error: colors.error,
      onError: Colors.white,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textMuted,
      outline: colors.border,
      outlineVariant: colors.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      extensions: <ThemeExtension<dynamic>>[colors],
      scaffoldBackgroundColor: colors.background,

      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: brightness.isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: colors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),

      textTheme: _textTheme(colors),

      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: brightness.isLight
              ? BorderSide.none
              : BorderSide(color: colors.border, width: 1.5),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: colors.surface,
        selectedItemColor: const Color(0xFF005BFF),
        unselectedItemColor: colors.textSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 46),
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: colors.primary,
          disabledForegroundColor: colors.textMuted,
          textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.link,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.inputFill,
        hintStyle: TextStyle(
          color: colors.inputHint,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        prefixIconColor: colors.inputIcon,
        suffixIconColor: colors.inputIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 12,
        ),
        border: _inputBorder(Colors.transparent),
        enabledBorder: _inputBorder(
          brightness.isLight ? colors.border : Colors.transparent,
        ),
        focusedBorder: _inputBorder(colors.primary),
        errorBorder: _inputBorder(colors.error),
        focusedErrorBorder: _inputBorder(colors.error),
      ),

      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 2,
        space: 1,
      ),

      iconTheme: IconThemeData(color: colors.textSecondary, size: 24),

      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        iconColor: colors.textSecondary,
        textColor: colors.textPrimary,
        titleTextStyle: TextStyle(
          color: colors.textPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: TextStyle(color: colors.textSecondary, fontSize: 14),
      ),

      snackBarTheme: SnackBarThemeData(
        elevation: 0,
        backgroundColor: colors.surfaceElevated,
        contentTextStyle: TextStyle(color: colors.textPrimary, fontSize: 14),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: colors.border),
        ),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: BorderSide(
        color: color,
        width: 1.2,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    );
  }

  static TextTheme _textTheme(AppPalette colors) {
    return TextTheme(
      displaySmall: TextStyle(
        color: colors.textPrimary,
        fontSize: 36,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: colors.textPrimary,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: TextStyle(
        color: colors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: colors.textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: colors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: colors.textPrimary,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: colors.textSecondary,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.3,
      ),
      bodyMedium: TextStyle(
        color: colors.textSecondary,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.3,
      ),
      bodySmall: TextStyle(
        color: colors.textMuted,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.25,
      ),
      labelLarge: TextStyle(
        color: colors.textPrimary,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        color: colors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: colors.textMuted,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.primary,
    required this.primarySoft,
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.surfaceLow,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.link,
    required this.inputFill,
    required this.inputHint,
    required this.inputIcon,
    required this.error,
    required this.success,
    required this.warning,
    required this.accepted,
    required this.acceptedText,
    required this.rejected,
    required this.rejectedText,
    required this.pending,
    required this.disabled,
  });

  final Color primary;
  final Color primarySoft;
  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color surfaceLow;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color link;
  final Color inputFill;
  final Color inputHint;
  final Color inputIcon;
  final Color error;
  final Color success;
  final Color warning;
  final Color accepted;
  final Color acceptedText;
  final Color rejected;
  final Color rejectedText;
  final Color pending;
  final Color disabled;

  static const dark = AppPalette(
    primary: Color(0xFF004BD1),
    primarySoft: Color(0x332F6BFF),
    background: Color(0xFF2A292E),
    surface: Color(0xFF36353C),
    surfaceElevated: Color(0xFF383740),
    surfaceLow: Color(0xFF323137),
    border: Color(0xFF45444D),
    textPrimary: Colors.white,
    textSecondary: Color(0xFFD0CDD7),
    textMuted: Color(0xFFA19EAA),
    link: Color(0xFF29B6F6),
    inputFill: Color(0xFFF8FAFC),
    inputHint: Color(0xFF5A5A5A),
    inputIcon: Color(0xFF5A5A5A),
    error: Color(0xFFD32F2F),
    success: Color(0xFF2E7D32),
    warning: Color(0xFFF59E0B),
    accepted: Color(0xFF30D158),
    acceptedText: Color(0xFF30D158),
    rejected: Color(0xFFFF453A),
    rejectedText: Color(0xFFFF453A),
    pending: Color(0xFF5A5863),
    disabled: Color(0xFF4A4850),
  );

  static const light = AppPalette(
    primary: Color(0xFF004BD1),
    primarySoft: Color(0x1A004BD1),
    background: Color(0xFFF5F7FB),
    surface: Colors.white,
    surfaceElevated: Colors.white,
    surfaceLow: Color(0xFFEFF1F5),
    border: Color(0xFFD8D8D9),
    textPrimary: Colors.black,
    textSecondary: Color(0xFF494744),
    textMuted: Color(0xFF7B7C7E),
    link: Color(0xFF004BD1),
    inputFill: Colors.white,
    inputHint: Color(0xFF7B7C7E),
    inputIcon: Color(0xFF7B7C7E),
    error: Color(0xFFD32F2F),
    success: Color(0xFF2E7D32),
    warning: Color(0xFFF59E0B),
    accepted: Color(0xFF30D158),
    acceptedText: Color(0xFF067647),
    rejected: Color(0xFFFF453A),
    rejectedText: Color(0xFFB42318),
    pending: Color(0xFFBDB8B0),
    disabled: Color(0xFFB8B9BC),
  );

  @override
  AppPalette copyWith({
    Color? primary,
    Color? primarySoft,
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? surfaceLow,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? link,
    Color? inputFill,
    Color? inputHint,
    Color? inputIcon,
    Color? error,
    Color? success,
    Color? warning,
    Color? accepted,
    Color? acceptedText,
    Color? rejected,
    Color? rejectedText,
    Color? pending,
    Color? disabled,
  }) {
    return AppPalette(
      primary: primary ?? this.primary,
      primarySoft: primarySoft ?? this.primarySoft,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceLow: surfaceLow ?? this.surfaceLow,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      link: link ?? this.link,
      inputFill: inputFill ?? this.inputFill,
      inputHint: inputHint ?? this.inputHint,
      inputIcon: inputIcon ?? this.inputIcon,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      accepted: accepted ?? this.accepted,
      acceptedText: acceptedText ?? this.acceptedText,
      rejected: rejected ?? this.rejected,
      rejectedText: rejectedText ?? this.rejectedText,
      pending: pending ?? this.pending,
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) {
      return this;
    }

    return AppPalette(
      primary: Color.lerp(primary, other.primary, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceLow: Color.lerp(surfaceLow, other.surfaceLow, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      link: Color.lerp(link, other.link, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      inputHint: Color.lerp(inputHint, other.inputHint, t)!,
      inputIcon: Color.lerp(inputIcon, other.inputIcon, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      accepted: Color.lerp(accepted, other.accepted, t)!,
      acceptedText: Color.lerp(acceptedText, other.acceptedText, t)!,
      rejected: Color.lerp(rejected, other.rejected, t)!,
      rejectedText: Color.lerp(rejectedText, other.rejectedText, t)!,
      pending: Color.lerp(pending, other.pending, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  bool get isLight => brightness.isLight;

  bool get isDark => brightness.isDark;

  AppPalette get appColors {
    return Theme.of(this).extension<AppPalette>() ?? AppPalette.dark;
  }
}

extension AppBrightness on Brightness {
  bool get isLight => this == Brightness.light;

  bool get isDark => this == Brightness.dark;
}

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 40;
}

abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double input = 16;
  static const double button = 16;
  static const double card = 16;
  static const double calendarTile = 12;
  static const double bottomNav = 24;
  static const double avatar = 999;
}

abstract final class AppShadows {
  static const navBarShadow = [
    BoxShadow(color: Colors.black12, blurRadius: 12),
  ];

  static const cardShadow = [
    BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 2)),
  ];

  static const calendarShadow = [
    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
  ];
}
