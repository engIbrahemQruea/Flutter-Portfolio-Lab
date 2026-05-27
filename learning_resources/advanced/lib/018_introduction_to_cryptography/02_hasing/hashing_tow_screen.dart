import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class HashingTowScreen extends StatefulWidget {
  const HashingTowScreen({super.key});

  @override
  State<HashingTowScreen> createState() => _HashingTowScreenState();
}

class _HashingTowScreenState extends State<HashingTowScreen> {
  // القيمة الافتراضية المأخوذة تماماً من كود السي شارب الخاص بك
  final TextEditingController _inputController = TextEditingController(
    text: "Ibrahim Qurea",
  );

  String _originalData = "Ibrahim Qurea";
  String _hashedData = "";

  @override
  void initState() {
    super.initState();
    // حساب الـ Hash تلقائياً للقيمة الافتراضية عند فتح الشاشة
    _hashedData = _computeHash(_originalData);
  }

  /// 🛠️ هذه الدالة هي التوأم المعماري المطابق تماماً لـ static string ComputeHash في كود الـ C#
  String _computeHash(String input) {
    if (input.isEmpty) return "";

    // 1️⃣ خطوة: Encoding.UTF8.GetBytes(input)
    final List<int> hashBytes = utf8.encode(input);

    // 2️⃣ خطوة: sha256.ComputeHash(...)
    final Digest digest = sha256.convert(hashBytes);

    // 3️⃣ خطوة: تحويل البايتات إلى نص Hexadecimal صغير ومطابق لـ ToLower() والـ Replace
    return digest.toString().toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔐 SHA-256 Hash Identifier'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 127, 147, 174),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // بطاقة المدخلات والمحاكاة
            Card(
              color: const Color.fromARGB(255, 205, 217, 233),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.grey, width: 0.3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "📥 كود السي شارب يمتلك نصاً ثابتاً، هنا يمكنك كتابة أي نص لتحديث الشاشة حياً:",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 47, 65, 74),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _inputController,
                      onChanged: (value) {
                        setState(() {
                          _originalData = value;
                          _hashedData = _computeHash(value); // تحديث فوري وحي
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Data Input',
                        labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurpleAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 🖥️ لوحة عرض المخرجات (تحاكي شاشة الـ Console الافتراضية)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF161B22),
                  borderRadius: BorderRadius.circular(12),
                  // border: BorderSide(color: Colors.deepPurpleAccent.withOpacity(0.4), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.terminal,
                          color: Colors.greenAccent,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Console Output Display",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 15,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 25),

                    // طباعة البيانات الأصلية (Original Data)
                    const Text(
                      "Original Data:",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _originalData.isEmpty ? "(فارغ)" : _originalData,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // طباعة البيانات المشفرة بالتجزئة (Hashed Data)
                    const Text(
                      "Hashed Data (SHA-256 Digest):",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1117),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _hashedData.isEmpty
                            ? "في انتظار البيانات..."
                            : _hashedData,
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 14,
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
}
