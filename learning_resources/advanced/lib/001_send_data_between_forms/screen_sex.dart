import 'package:flutter/material.dart';

// 1. هذا هو الـ Delegate (العقد): دالة تأخذ نصاً ولا تعيد شيئاً
typedef OnDataReceivedDelegate = void Function(String data);

// --- الشاشة الثانية (المستقبلة للـ Delegate والمرسِلة للبيانات للخلف) ---
class delegateScreenSeven extends StatelessWidget {
  // 2. متغير يحمل الإشارة إلى الدالة (مثل متغير الـ Delegate في #C)
  final OnDataReceivedDelegate onDataBack;

  const delegateScreenSeven({super.key, required this.onDataBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Sex Using TypeDef')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 4. استدعاء الـ Delegate وإرسال البيانات للخلف
            onDataBack("Hello from Screen Sex via Delegate!");
            Navigator.pop(context); // إغلاق الشاشة
          },
          child: const Text('Send Data Back to Form 1'),
        ),
      ),
    );
  }
}
