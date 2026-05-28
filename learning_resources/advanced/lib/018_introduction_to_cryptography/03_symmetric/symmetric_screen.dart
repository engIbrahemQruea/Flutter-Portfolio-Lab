import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt_pkg;
import 'package:flutter/material.dart';

class SymmetricAesScreen extends StatefulWidget {
  const SymmetricAesScreen({super.key});

  @override
  State<SymmetricAesScreen> createState() => _SymmetricAesScreenState();
}

class _SymmetricAesScreenState extends State<SymmetricAesScreen> {
  // استخدام نفس البيانات والمفاتيح الافتراضية المذكورة في كود الـ C# الخاص بك
  final TextEditingController _dataController = TextEditingController(
    text: "Sensitive information",
  );
  final TextEditingController _keyController = TextEditingController(
    text: "1234567890123456",
  );

  String _encryptedData = "";
  String _decryptedData = "";
  String _uiError = "";

  /// 🛠️ دالة التشفير المتطابقة تماماً مع static string Encrypt في C#
  String _encrypt(String plainText, String keyText) {
    if (keyText.length != 16) {
      setState(
        () => _uiError =
            "❌ خطأ في السعة: يجب أن يكون طول المفتاح 16 حرفاً (128-bit)",
      );
      return "";
    }

    // 1. تحويل المفتاح إلى بايتات: Encoding.UTF8.GetBytes(key)
    final key = encrypt_pkg.Key.fromUtf8(keyText);

    // 2. إنشاء مصفوفة بايتات فارغة (أصفار) لـ IV تماماً مثل: new byte[aesAlg.BlockSize / 8]
    final Uint8List zeroBytes = Uint8List(16); // 16 بايت مليئة بالأصفار
    final iv = encrypt_pkg.IV(zeroBytes);

    // 3. تهيئة المحرك على وضعية CBC (وهي الوضعية الافتراضية لكلاس Aes في دوت نت)
    final encrypter = encrypt_pkg.Encrypter(
      encrypt_pkg.AES(key, mode: encrypt_pkg.AESMode.cbc),
    );

    // 4. التشفير وإخراج نص Base64
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  /// 🛠️ دالة فك التشفير المتطابقة تماماً مع static string Decrypt في C#
  String _decrypt(String cipherTextBase64, String keyText) {
    if (cipherTextBase64.isEmpty || keyText.length != 16) return "";

    final key = encrypt_pkg.Key.fromUtf8(keyText);
    final Uint8List zeroBytes = Uint8List(16);
    final iv = encrypt_pkg.IV(zeroBytes);

    final encrypter = encrypt_pkg.Encrypter(
      encrypt_pkg.AES(key, mode: encrypt_pkg.AESMode.cbc),
    );

    try {
      // فك التشفير واستعادة النص المقروء
      final decrypted = encrypter.decrypt64(cipherTextBase64, iv: iv);
      return decrypted;
    } catch (e) {
      return "❌ فشل فك التشفير (مفتاح خاطئ)";
    }
  }

  void _runCryptographicPipeline() {
    setState(() {
      _uiError = "";
      // تشغيل التشفير
      _encryptedData = _encrypt(_dataController.text, _keyController.text);
      // تشغيل فك التشفير مباشرة بناءً على الناتج السابق لتبسيط العرض
      _decryptedData = _decrypt(_encryptedData, _keyController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🖥️ AES-128 Console Mirror UI'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 111, 145, 193),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // لوحة المدخلات التفاعلية
            TextField(
              controller: _dataController,
              decoration: const InputDecoration(
                labelText: 'Original Data (النص الحساس)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _keyController,
              maxLength: 16,
              decoration: const InputDecoration(
                labelText: 'AES Encryption Key (128-bit / 16 Chars)',
                border: OutlineInputBorder(),
              ),
            ),

            if (_uiError.isNotEmpty)
              Text(_uiError, style: const TextStyle(color: Colors.redAccent)),

            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent.shade700,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _runCryptographicPipeline,
              icon: const Icon(Icons.play_arrow),
              label: const Text("Execute Cryptographic Operation"),
            ),
            const SizedBox(height: 25),

            // 🖥️ مرآة شاشة الـ Console لعرض النتائج حياً
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF161B22),
                  borderRadius: BorderRadius.circular(12),
                  //olor: Colors.blueAccent.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.terminal, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text(
                          "Console Window Output",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 25),

                    _buildConsoleLine(
                      "Original Data: ",
                      _dataController.text,
                      Colors.white,
                    ),
                    const SizedBox(height: 15),
                    _buildConsoleLine(
                      "Encrypted Data: ",
                      _encryptedData,
                      Colors.amberAccent,
                    ),
                    const SizedBox(height: 15),
                    _buildConsoleLine(
                      "Decrypted Data: ",
                      _decryptedData,
                      Colors.greenAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsoleLine(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Courier',
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value.isEmpty ? "(في انتظار تشغيل العملية...)" : value,
            style: TextStyle(
              fontFamily: 'Courier',
              color: value.isEmpty ? Colors.grey : valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
