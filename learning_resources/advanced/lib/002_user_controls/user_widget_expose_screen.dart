import 'package:advanced/002_user_controls/custom_simple_calc_expose.dart';
import 'package:flutter/material.dart';

class UserWidgetExposeScreen extends StatelessWidget {
  final GlobalKey<SimpleCalcComponentState> _simpleCalcKey = GlobalKey();
  UserWidgetExposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Widget Expose')),
      body: Column(
        children: [
          Text('This is the User Widget Expose Screen'),

          SimpleCalcComponent(key: _simpleCalcKey),
          const SizedBox(height: 30),

          // 2. زر خارجي في الشاشة الرئيسية يقرأ النتيجة من داخل الـ User Control
          ElevatedButton.icon(
            icon: const Icon(Icons.get_app),
            label: const Text('قراءة النتيجة من الشاشة الرئيسية'),
            onPressed: () {
              // قراءة الـ Property (result) المكشوفة من الـ User Control
              final currentResult = _simpleCalcKey.currentState?.result ?? 0.0;

              // عرض النتيجة في SnackBar كمثال على استخدامها خارجياً
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('النتيجة المستلمة في الخارجية: $currentResult'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
