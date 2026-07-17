import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDialogs {
  static void showSuccess({
    required BuildContext context,
    required String message,
    String buttonText = 'موافق',
    VoidCallback? onPressed,
  }) {
    _showGenericDialog(
      context: context,
      message: message,
      buttonText: buttonText,
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 48,
      ),
      title: 'عملية ناجحة',
      titleColor: Colors.green,
      onPressed: onPressed,
    );
  }

  static void showFailure({
    required BuildContext context,
    required String message,
    String buttonText = 'حاول مجدداً',
    VoidCallback? onPressed,
  }) {
    _showGenericDialog(
      context: context,
      message: message,
      buttonText: buttonText,
      icon: const Icon(
        Icons.error_outline_rounded,
        color: Colors.red,
        size: 48,
      ),
      title: 'حدث خطأ ما',
      titleColor: Colors.red,
      onPressed: onPressed,
    );
  }

  static void _showGenericDialog({
    required BuildContext context,
    required String message,
    required String buttonText,
    required Widget icon,
    required String title,
    required Color titleColor,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: .circular(16)),
          contentPadding: const .symmetric(horizontal: 24, vertical: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .bold,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: .center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
          actionsAlignment: .center,
          actionsPadding: const .only(bottom: 16),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: titleColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              onPressed: () {
                context.pop();
                if (onPressed != null) onPressed();
              },
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
