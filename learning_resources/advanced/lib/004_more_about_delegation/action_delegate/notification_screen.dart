import 'package:flutter/material.dart';

import 'action_logic.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationManager _manager = NotificationManager();
  final TextEditingController _msgController = TextEditingController(
    text: "تم تحديث البيانات بنجاح!",
  );

  void _handleNotification(NotificationAction chosenAction) {
    // نمرر الـ Context، النص، ودالة الـ Action المحددة للـ Manager
    _manager.triggerNotification(context, _msgController.text, chosenAction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظام التنبيهات التفاعلي (Action Delegate)'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _msgController,
              decoration: const InputDecoration(
                labelText: 'اكتب نص التنبيه المراد إرساله 🔔:',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'اختر الـ Action (طريقة العرض النفّاذة):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 12),

            // زر لتفويض الـ SnackBar Action
            ElevatedButton.icon(
              onPressed: () => _handleNotification(AlertStyles.showSnackBar),
              icon: const Icon(Icons.dns),
              label: const Text('عرض كـ SnackBar أسفل الشاشة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 10),

            // زر لتفويض الـ Alert Dialog Action
            ElevatedButton.icon(
              onPressed: () => _handleNotification(AlertStyles.showAlertDialog),
              icon: const Icon(Icons.picture_in_picture),
              label: const Text('عرض كـ AlertDialog في المنتصف'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade900,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
