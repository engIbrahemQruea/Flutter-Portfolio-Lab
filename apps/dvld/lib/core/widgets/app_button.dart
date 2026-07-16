import 'package:flutter/material.dart';

// =========================================================================
// 1. تعريف المتغيرات والأنماط الحديثة (Dart Enhanced Enums)
// =========================================================================

enum AppButtonStyle {
  primary,
  secondary;

  Color getBackgroundColor(ThemeData theme, bool isDisabled) {
    if (isDisabled) return theme.disabledColor;
    return switch (this) {
      AppButtonStyle.primary => theme.colorScheme.primary,
      AppButtonStyle.secondary => theme.colorScheme.secondaryContainer,
    };
  }
  Color getForegroundColor(ThemeData theme, bool isDisabled) {
    if (isDisabled) return theme.colorScheme.onSurface.withValues(alpha: 0.38);
    return switch (this) {
      AppButtonStyle.primary => theme.colorScheme.onPrimary,
      AppButtonStyle.secondary => theme.colorScheme.onSecondaryContainer,
    };
  }
}

enum AppButtonSize {
  small(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    iconSize: 16.0,
    borderRadius: 8.0,
    fontSize: 12.0,
  ),
  medium(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    iconSize: 20.0,
    borderRadius: 12.0,
    fontSize: 14.0,
  ),
  large(
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    iconSize: 24.0,
    borderRadius: 16.0,
    fontSize: 16.0,
  );

  final EdgeInsets padding;
  final double iconSize;
  final double borderRadius;
  final double fontSize;

  const AppButtonSize({
    required this.padding,
    required this.iconSize,
    required this.borderRadius,
    required this.fontSize,
  });
}

// =========================================================================
// 2. منظومة الثيم المخصصة للزر (Custom Inherited Theme)
// =========================================================================

class AppButtonTheme extends InheritedWidget {
  final Duration animationDuration;

  const AppButtonTheme({
    super.key,
    this.animationDuration = const Duration(milliseconds: 200),
    required super.child,
  });

  static AppButtonTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppButtonTheme>() ??
        const AppButtonTheme(child: SizedBox.shrink());
  }

  @override
  bool updateShouldNotify(AppButtonTheme oldWidget) =>
      animationDuration != oldWidget.animationDuration;
}

// =========================================================================
// 3. المكونات الرسومية (UI Components)
// =========================================================================

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonStyle _style;
  final AppButtonSize _size;
  final Widget? _icon;
  final bool _loading;

  const AppButton({super.key, required this.label, this.onPressed})
    : _style = AppButtonStyle.primary,
      _size = AppButtonSize.medium,
      _icon = null,
      _loading = false;

  const AppButton.secondary({super.key, required this.label, this.onPressed})
    : _style = AppButtonStyle.secondary,
      _size = AppButtonSize.medium,
      _icon = null,
      _loading = false;

  const AppButton.icon({
    super.key,
    required this.label,
    required Widget icon,
    this.onPressed,
  }) : _style = AppButtonStyle.primary,
       _size = AppButtonSize.medium,
       _icon = icon,
       _loading = false;

  const AppButton.custom({
    super.key,
    required this.label,
    this.onPressed,
    AppButtonStyle style = AppButtonStyle.primary,
    AppButtonSize size = AppButtonSize.medium,
    Widget? icon,
    bool loading = false,
  }) : _style = style,
       _size = size,
       _icon = icon,
       _loading = loading;

  @override
  Widget build(BuildContext context) {
    return _ButtonBuilder(
      style: _style,
      size: _size,
      icon: _icon,
      loading: _loading,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _ButtonBuilder extends StatelessWidget {
  final AppButtonStyle style;
  final AppButtonSize size;
  final Widget? icon;
  final bool loading;
  final VoidCallback? onPressed;
  final Widget child;

  const _ButtonBuilder({
    required this.style,
    required this.size,
    this.icon,
    required this.loading,
    this.onPressed,
    required this.child,
  });

  // التحكم في حالة التعطيل البرمجي (Disabled)
  bool get _isDisabled => onPressed == null || loading;

  // تنفيذ الدوال المساعدة المطلوبة في الكود الخاص بك
  Color _getBackgroundColor(ThemeData theme) =>
      style.getBackgroundColor(theme, _isDisabled);
  double _getBorderRadius() => size.borderRadius;
  EdgeInsets _getPadding() => size.padding;
  double _getIconSize() => size.iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonTheme = AppButtonTheme.of(context);
    final foregroundColor = style.getForegroundColor(theme, _isDisabled);

    return AnimatedContainer(
      duration: buttonTheme.animationDuration,
      child: Material(
        color: _getBackgroundColor(theme),
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        child: InkWell(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          onTap: _isDisabled ? null : onPressed,
          child: Container(
            padding: _getPadding(),
            // نستخدم حوامل لتمرير تنسيق الألوان الموحد للنصوص والأيقونات بالداخل ديناميكياً
            child: IconTheme(
              data: IconThemeData(color: foregroundColor, size: _getIconSize()),
              child: DefaultTextStyle(
                style: theme.textTheme.labelLarge!.copyWith(
                  color: foregroundColor,
                  fontSize: size.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_buildContent()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (loading) {
      return SizedBox(
        height: _getIconSize(),
        width: _getIconSize(),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [icon!, const SizedBox(width: 8), child],
      );
    }

    return child;
  }
}
