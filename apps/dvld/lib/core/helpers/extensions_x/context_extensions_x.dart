import 'package:flutter/material.dart';

extension ThemeExtensionX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get onPrimaryColor => Theme.of(this).colorScheme.onPrimary;

  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!;

  Brightness get brightness => Theme.of(this).brightness;
  bool get isDarkMode => brightness == Brightness.dark;
  bool get isLightMode => brightness == Brightness.light;
}

/// Extensions for [MediaQuery]
extension MediaQueryExtensionX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  double get paddingTop => MediaQuery.paddingOf(this).top;
  double get paddingBottom => MediaQuery.paddingOf(this).bottom;
  double get safeAreaTop => paddingTop;
  double get safeAreaBottom => paddingBottom;

  double get statusBarHeight => MediaQuery.viewPaddingOf(this).top;
  double get bottomBarHeight => MediaQuery.viewPaddingOf(this).bottom;

  double get widthPercent10 => screenWidth * 0.1;
  double get widthPercent20 => screenWidth * 0.2;
  double get widthPercent50 => screenWidth * 0.5;

  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;

  bool get isPortrait => screenSize.height > screenWidth;
  bool get isLandscape => screenSize.width > screenHeight;

  bool get isTablet => screenWidth > 600;
  bool get isDesktop => screenWidth > 1200;
}
