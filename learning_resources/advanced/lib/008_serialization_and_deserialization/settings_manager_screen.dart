import 'package:flutter/material.dart';

import 'app_settings.dart';

class SettingsManagerScreen extends StatefulWidget {
  const SettingsManagerScreen({super.key});

  @override
  State<SettingsManagerScreen> createState() => _SettingsManagerScreenState();
}

class _SettingsManagerScreenState extends State<SettingsManagerScreen> {
  // الكائن الأصلي المخزن في الذاكرة
  AppSettings _currentSettings = AppSettings(
    themeMode: "داكن (Dark)",
    isNotificationsEnabled: true,
    cacheSizeInMB: 64,
  );

  AppSettings? _clonedSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة ونسخ الكائنات (Advanced Serialization)'),
        backgroundColor: Colors.teal.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // عرض الكائن الأصلي الأول
            _buildCard(
              "الكائن الأصلي الحالي (Original State)",
              "الوضع البصري: ${_currentSettings.themeMode}\nالإشعارات: ${_currentSettings.isNotificationsEnabled ? 'مفعلة ✅' : 'معطلة ❌'}\nحجم الكاش: ${_currentSettings.cacheSizeInMB} ميغابايت",
              Colors.teal.shade50,
            ),

            const SizedBox(height: 16),

            // زر الاستنساخ العميق (Deep Copy)
            ElevatedButton.icon(
              icon: const Icon(Icons.copy),
              label: const Text('تنفيذ استنساخ عميق (Deep Copy / Cloning)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  // 🎯 قمنا بعمل نسخة مطابقة تماماً ومنفصلة في الذاكرة مع تعديل حجم الكاش فقط
                  _clonedSettings = _currentSettings.copyWith(
                    cacheSizeInMB: 128,
                  );
                });
              },
            ),

            const SizedBox(height: 16),

            // عرض الكائن المستنسخ الجديد بشكل منفصل
            if (_clonedSettings != null) ...[
              _buildCard(
                "الكائن المستنسخ الجديد في الذاكرة (Cloned Object)",
                "الوضع البصري: ${_clonedSettings!.themeMode}\nالإشعارات: ${_clonedSettings!.isNotificationsEnabled ? 'مفعلة ✅' : 'معطلة ❌'}\nحجم الكاش الجديد: ${_clonedSettings!.cacheSizeInMB} ميغابايت",
                Colors.amber.shade50,
              ),

              const SizedBox(height: 12),
              const Text(
                '💡 لاحظ: تم تعديل حجم الكاش في الكائن المستنسخ إلى 128 ميغابايت، بينما ظل الكائن الأصلي محتفظاً بقيمته (64 ميغابايت) دون تأثر! هذا هو الأمان البرمجي المطلوب في الأنظمة الموزعة والتأمين ضد الأخطاء.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String content, Color bgColor) {
    return Card(
      color: bgColor,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            const Divider(height: 20),
            Text(content, style: const TextStyle(fontSize: 16, height: 1.4)),
          ],
        ),
      ),
    );
  }
}
