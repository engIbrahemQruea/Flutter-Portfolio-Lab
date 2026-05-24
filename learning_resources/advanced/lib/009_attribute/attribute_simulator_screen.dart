import 'package:advanced/009_attribute/legacy_service.dart';
import 'package:flutter/material.dart';

class AttributeSimulatorScreen extends StatelessWidget {
  const AttributeSimulatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = OldDatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('عالم الـ Attributes & Annotations'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.amber == true ? Colors.black : Colors.amberAccent,
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.teal,
                      size: 30,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'ملاحظة هندسية: انظر لشفرة الكود البرمجي (في المحرر) ستلاحظ وجود خط شطب فوق الدالة القديمة بفضل عامل الـ @deprecated المتطابق مع [Obsolete].',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // عند كتابة السطر التالي في VS Code أو Android Studio ستجده مشطوباً تلقائياً ❌
                // بفضل الـ Annotation الذكي
                service.saveDataToLocalFile("بيانات المستخدم");
              },
              child: const Text('استدعاء الدالة المهجورة (Deprecated)'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // الدالة المعاصرة الموصى بها
                service.saveDataToSecureStorage("بيانات مشفرة آمنة");
              },
              child: const Text('استدعاء الدالة الحديثة المستقرة'),
            ),
          ],
        ),
      ),
    );
  }
}

// ثيمات لونية مساعدة للبطاقة التحذيرية
class ColorsAmber {
  static const Color solitude = Color(0xFFFFFDE7);
  static const Color dark = Color(0xFFF57F17);
}

extension on Colors {
  static const Color amberSolitude = ColorsAmber.solitude;
  static const Color amberDark = ColorsAmber.dark;
  static bool? get amputated => null;
}
