// Design tokens - the source of truth for all design decisions
import 'package:flutter/material.dart';

class AppTokens {
  // Spacing scale
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;

  // Border radius scale
  static const double radiusXs = 2.0;
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radius2xl = 24.0;
  static const double radiusFull = 9999.0;

  // Typography scale
  static const double fontXs = 12.0;
  static const double fontSm = 14.0;
  static const double fontBase = 16.0;
  static const double fontLg = 18.0;
  static const double fontXl = 20.0;
  static const double font2xl = 24.0;
  static const double font3xl = 30.0;
  static const double font4xl = 36.0;

  // Animation durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationBase = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 400);

  // Z-index scale
  static const double zIndex1 = 10;
  static const double zIndex2 = 20;
  static const double zIndex3 = 30;
  static const double zIndexModal = 1000;
  static const double zIndexTooltip = 1010;
  static const double zIndexToast = 1020;
}

// Semantic color system that references design tokens
class AppColors {
  // Primary colors
  static const Color primary50 = Color(0xFFF0F9FF);
  static const Color primary100 = Color(0xFFE0F2FE);
  static const Color primary500 = Color(0xFF0EA5E9);
  static const Color primary600 = Color(0xFF0284C7);
  static const Color primary900 = Color(0xFF0C4A6E);

  // Semantic colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Neutral colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);
}

// Typography system built on tokens
class AppTextStyles {
  static TextStyle get displayLarge => TextStyle(
    fontSize: AppTokens.font4xl,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.02,
    height: 1.1,
  );

  static TextStyle get displayMedium => TextStyle(
    fontSize: AppTokens.font3xl,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.01,
    height: 1.2,
  );

  static TextStyle get headlineLarge => TextStyle(
    fontSize: AppTokens.font2xl,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontSize: AppTokens.fontLg,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: AppTokens.fontBase,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get labelMedium => TextStyle(
    fontSize: AppTokens.fontSm,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
}

// Component-specific theme that uses tokens
class AppButtonTheme {
  static const EdgeInsets paddingSmall = EdgeInsets.symmetric(
    horizontal: AppTokens.space3,
    vertical: AppTokens.space2,
  );

  static const EdgeInsets paddingMedium = EdgeInsets.symmetric(
    horizontal: AppTokens.space4,
    vertical: AppTokens.space3,
  );

  static const EdgeInsets paddingLarge = EdgeInsets.symmetric(
    horizontal: AppTokens.space6,
    vertical: AppTokens.space4,
  );

  static const double borderRadiusSmall = AppTokens.radiusSm;
  static const double borderRadiusMedium = AppTokens.radiusMd;
  static const double borderRadiusLarge = AppTokens.radiusLg;

  static const Duration animationDuration = AppTokens.durationBase;
}
