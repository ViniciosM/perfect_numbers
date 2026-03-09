import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static const _primaryColor = Color(0xFF00E5C3);
  static const _bgDark = Color(0xFF0D0F14);
  static const _surfaceDark = Color(0xFF161A23);
  static const _cardDark = Color(0xFF1E2330);
  static const _errorColor = Color(0xFFFF5C6A);
  static const _successColor = Color(0xFF00E5C3);

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _bgDark,
      colorScheme: const ColorScheme.dark(
        primary: _primaryColor,
        surface: _surfaceDark,
        error: _errorColor,
      ),
      textTheme: GoogleFonts.spaceGroteskTextTheme(
        ThemeData.dark().textTheme,
      ).apply(bodyColor: Colors.white, displayColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _errorColor, width: 1.5),
        ),
        labelStyle: const TextStyle(color: Colors.white54),
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: _bgDark,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: _cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      extensions: const [
        AppColors(
          success: _successColor,
          error: _errorColor,
          card: _cardDark,
          surface: _surfaceDark,
          bg: _bgDark,
        ),
      ],
    );
  }
}

class AppColors extends ThemeExtension<AppColors> {
  final Color success;
  final Color error;
  final Color card;
  final Color surface;
  final Color bg;

  const AppColors({
    required this.success,
    required this.error,
    required this.card,
    required this.surface,
    required this.bg,
  });

  @override
  AppColors copyWith({
    Color? success,
    Color? error,
    Color? card,
    Color? surface,
    Color? bg,
  }) {
    return AppColors(
      success: success ?? this.success,
      error: error ?? this.error,
      card: card ?? this.card,
      surface: surface ?? this.surface,
      bg: bg ?? this.bg,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      card: Color.lerp(card, other.card, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      bg: Color.lerp(bg, other.bg, t)!,
    );
  }
}
