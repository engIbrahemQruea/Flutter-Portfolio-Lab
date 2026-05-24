import 'package:flutter/material.dart';

import 'user_model.dart';

class SerializationScreen extends StatefulWidget {
  const SerializationScreen({super.key});

  @override
  State<SerializationScreen> createState() => _SerializationScreenState();
}

class _SerializationScreenState extends State<SerializationScreen> {
  // 1. كائن حي داخل الذاكرة (RAM)
  final UserModel _originalUser = UserModel(
    username: "Abu-Hadhoud Fans",
    email: "info@programmingadvices.com",
    points: 950,
  );

  String _serializedJson = "";
  UserModel? _reconstructedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serialization & Deserialization'),
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // عرض الكائن الأصلي
            _buildCard(
              "1. الكائن الأصلي في الذاكرة (Object)",
              "الاسم: ${_originalUser.username}\nالإيميل: ${_originalUser.email}\nالنقاط: ${_originalUser.points}",
              Colors.indigo.shade50,
            ),

            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_downward),
              label: const Text('تشغيل الـ Serialization (تحويل لـ JSON)'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              onPressed: () {
                setState(() {
                  // تحويل الكائن إلى نص مفرغ تماماً كما تشرح الورقة رقم 9 [cite: 63]
                  _serializedJson = _originalUser.toJson();
                });
              },
            ),

            // عرض النص المتسلسل الناتج
            if (_serializedJson.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildCard(
                "2. النص الناتج القابل للنقل/الحفظ (Serialized Form)",
                _serializedJson,
                Colors.amber.shade50,
                isCode: true,
              ),

              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.settings_backup_restore),
                label: const Text(
                  'تشغيل الـ Deserialization (إعادة بناء الكائن)',
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  setState(() {
                    // إعادة بناء كائن حي من النص المتسلسل
                    _reconstructedUser = UserModel.fromJson(_serializedJson);
                  });
                },
              ),
            ],

            // عرض الكائن بعد إعادة تشكيله
            if (_reconstructedUser != null) ...[
              const SizedBox(height: 12),
              _buildCard(
                "3. الكائن المستعاد في الذاكرة (Reconstructed Object)",
                "تمت استعادة العضو الحركي بنجاح:\nالاسم: ${_reconstructedUser!.username}\nالنقاط المسترجعة: ${_reconstructedUser!.points}",
                Colors.green.shade50,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    String title,
    String content,
    Color bgColor, {
    bool isCode = false,
  }) {
    return Card(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const Divider(),
            Text(
              content,
              style: TextStyle(
                fontFamily: isCode ? 'monospace' : null,
                fontSize: 15,
                fontWeight: isCode ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
