import 'package:flutter/material.dart';

// تعريف الـ Typedef ليعبر عن الـ Action في سي شارب الذي يستقبل نصاً وسياقاً للواجهة
typedef NotificationAction =
    void Function(BuildContext context, String message);

class NotificationManager {
  // دالة الإطلاق تستقبل النص، والدالة المفوضة (الـ Action) التي ستحدد شكل ظهور التنبيه
  void triggerNotification(
    BuildContext context,
    String text,
    NotificationAction action,
  ) {
    // تنفيذ الـ Action مباشرة (لا توجد قيمة مرجعة هنا، هو مجرد أمر تنفيذ واجهة)
    action(context, text);
  }
}

// الطرق المختلفة المتاحة لعرض التنبيهات (تمثل الـ Actions خلف الكواليس)
class AlertStyles {
  // الأسلوب الأول: عرض SnackBar أسفل الشاشة
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // الأسلوب الثاني: عرض Dialog (صندوق حواري بثق في منتصف الشاشة)
  static void showAlertDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.amber),
            SizedBox(width: 8),
            Text('تحذير من النظام'),
          ],
        ),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسنًا'),
          ),
        ],
      ),
    );
  }
}
