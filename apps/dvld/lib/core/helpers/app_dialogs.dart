import 'package:flutter/material.dart';

/// [AppDialogs] - Unified, Theme-Aware, and Production-Ready Dialog System.
/// Designed for clean navigation control and async result handling.
abstract class AppDialogs {
  AppDialogs._(); // Private constructor to prevent instantiation

  // ===========================================================================
  // 1. UTILITY METHOD FOR SAFE DISMISSAL
  // ===========================================================================

  /// Closes the topmost dialog safely using rootNavigator to prevent breaking GoRouter stack.
  static void dismiss<T>(BuildContext context, [T? result]) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(result);
    }
  }

  // ===========================================================================
  // 2. PUBLIC DIALOG VARIANTS
  // ===========================================================================

  /// Shows a Success Dialog
  static Future<void> showSuccess({
    required BuildContext context,
    required String message,
    String title = 'عملية ناجحة',
    String buttonText = 'موافق',
    VoidCallback? onPressed,
  }) {
    return _showBaseDialog<void>(
      context: context,
      title: title,
      message: message,
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 48,
      ),
      primaryButtonText: buttonText,
      primaryButtonColor: Colors.green,
      onPrimaryPressed: (dialogCtx) {
        dismiss(dialogCtx);
        onPressed?.call();
      },
    );
  }

  /// Shows an Error/Failure Dialog
  static Future<void> showFailure({
    required BuildContext context,
    required String message,
    String title = 'حدث خطأ ما',
    String buttonText = 'حاول مجدداً',
    VoidCallback? onPressed,
  }) {
    final theme = Theme.of(context);
    return _showBaseDialog<void>(
      context: context,
      title: title,
      message: message,
      icon: const Icon(
        Icons.error_outline_rounded,
        color: Colors.red,
        size: 48,
      ),
      primaryButtonText: buttonText,
      primaryButtonColor: theme.colorScheme.error,
      onPrimaryPressed: (dialogCtx) {
        dismiss(dialogCtx);
        onPressed?.call();
      },
    );
  }

  /// Shows a Warning Dialog
  static Future<void> showWarning({
    required BuildContext context,
    required String message,
    String title = 'تحذير',
    String buttonText = 'فهمت',
    VoidCallback? onPressed,
  }) {
    return _showBaseDialog<void>(
      context: context,
      title: title,
      message: message,
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.amber,
        size: 48,
      ),
      primaryButtonText: buttonText,
      primaryButtonColor: Colors.amber.shade800,
      onPrimaryPressed: (dialogCtx) {
        dismiss(dialogCtx);
        onPressed?.call();
      },
    );
  }

  /// Shows a Confirmation Dialog (Returns `Future<bool?>` for elegant awaiting)
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String message,
    String title = 'تأكيد الإجراء',
    String confirmText = 'تأكيد',
    String cancelText = 'إلغاء',
    Color? confirmColor,
    Widget? icon,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);
    final effectiveColor =
        confirmColor ??
        (isDestructive ? theme.colorScheme.error : theme.colorScheme.primary);

    return _showBaseDialog<bool>(
      context: context,
      title: title,
      message: message,
      icon:
          icon ??
          Icon(
            isDestructive
                ? Icons.delete_forever_rounded
                : Icons.help_outline_rounded,
            color: effectiveColor,
            size: 48,
          ),
      primaryButtonText: confirmText,
      primaryButtonColor: effectiveColor,
      onPrimaryPressed: (dialogCtx) => dismiss(dialogCtx, true),
      secondaryButtonText: cancelText,
      onSecondaryPressed: (dialogCtx) => dismiss(dialogCtx, false),
    );
  }

  /// Shows a Non-Dismissible Loading Dialog
  static Future<void> showLoading({
    required BuildContext context,
    String message = 'جاري التحميل...',
  }) {
    final theme = Theme.of(context);
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (ctx) => PopScope(
        canPop: false,

        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator.adaptive(),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. PRIVATE CORE BASE DIALOG BUILDER
  // ===========================================================================

  static Future<T?> _showBaseDialog<T>({
    required BuildContext context,
    required String title,
    required String message,
    required Widget icon,
    required String primaryButtonText,
    required Color primaryButtonColor,
    required Function(BuildContext dialogContext) onPrimaryPressed,
    String? secondaryButtonText,
    Function(BuildContext dialogContext)? onSecondaryPressed,
    bool barrierDismissible = false,
  }) {
    final theme = Theme.of(context);

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: true,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          actionsPadding: const EdgeInsets.only(
            bottom: 16,
            left: 16,
            right: 16,
          ),
          actions: [
            Row(
              children: [
                if (secondaryButtonText != null) ...[
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: theme.dividerColor),
                      ),
                      onPressed: () => onSecondaryPressed?.call(ctx),
                      child: Text(
                        secondaryButtonText,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryButtonColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () => onPrimaryPressed(ctx),
                    child: Text(
                      primaryButtonText,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
