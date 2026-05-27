import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class HashingScreen extends StatefulWidget {
  const HashingScreen({super.key});

  @override
  State<HashingScreen> createState() => _HashingScreenState();
}

class _HashingScreenState extends State<HashingScreen> {
  // جهاز التحكم بقراءة النص من صندوق الإدخال
  final TextEditingController _textController = TextEditingController();
  
  // متغيرات حفظ النتائج لعرضها على الشاشة
  String _inputText = "";
  String _sha256Result = "";
  int _textLength = 0;

  /// الدالة المسؤولة عن حساب الـ Hash وتحديث الواجهة فوراً
  void _computeHash(String value) {
    if (value.isEmpty) {
      setState(() {
        _inputText = "";
        _sha256Result = "";
        _textLength = 0;
      });
      return;
    }

    // 1. تحويل النص المكتوب إلى مصفوفة بايتات (List<int>)
    final List<int> bytes = utf8.encode(value);

    // 2. تمرير البايتات إلى خوارزمية SHA-256 القياسية
    final Digest digest = sha256.convert(bytes);

    // 3. تحديث حالة الواجهة (State) لعرض المخرجات على الشاشة
    setState(() {
      _inputText = value;
      _sha256Result = digest.toString(); // يعيد سلسلة الـ Hexadecimal المكونة من 64 حرفاً
      _textLength = value.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔒 SHA-256 Hashing Live Tool'),
        centerTitle: true,
        backgroundColor: const Color(0xFF161E2E),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "اكتب كلمة المرور أو النص في الصندوق أدناه، وشاهد كيف يقوم محرك التجزئة بتوليد البصمة الرقمية حياً على الشاشة:",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 📥 صندوق إدخال النص (Input Text Field)
            TextField(
              controller: _textController,
              onChanged: _computeHash, // استدعاء دالة التجزئة تلقائياً مع كل حرف يكتبه المستخدم
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Plaintext (النص الواضح / كلمة المرور)',
                labelStyle: const TextStyle(color: Colors.amber),
                hintText: 'ابدأ بالكتابة هنا...',
                prefixIcon: const Icon(Icons.security, color: Colors.amber),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.amber, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // 🖥️ لوحة عرض المخرجات على الشاشة (Screen Output Dashboard)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF161E2E),
                  borderRadius: BorderRadius.circular(12),
                 // border: BorderSide(color: Colors.amber.withOpacity(0.3), width: 1),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.analytics, color: Colors.amber, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Live Output (المخرجات الحية على الشاشة)",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey, height: 30),

                      // عرض طول النص الحالي
                      _buildInfoRow("طول النص الحالي:", "$_textLength حروف"),
                      const SizedBox(height: 15),

                      // عرض النص المدخل
                      _buildInfoRow("النص الأصلي المتأثر:", _inputText.isEmpty ? "(فارغ)" : _inputText),
                      const SizedBox(height: 25),

                      // صندوق عرض الـ Hash النهائي المكون من 64 حرفاً
                      const Text(
                        "SHA-256 Hash Digest (البصمة الرقمية الناتجة):",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.amber),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF090D14),
                          borderRadius: BorderRadius.circular(8),
                         // border: BorderSide(color: Colors.grey.withOpacity(0.2)),
                        ),
                        child: Text(
                          _sha256Result.isEmpty 
                              ? "في انتظار كتابة أي نص..." 
                              : _sha256Result,
                          style: TextStyle(
                            fontFamily: 'Courier', // استخدام خط مخصص للأكواد البرمجية ليكون مصفوفاً بشكل متساوٍ
                            fontSize: 14,
                            color: _sha256Result.isEmpty ? Colors.grey : Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت مساعدة لتنسيق الأسطر داخل لوحة العرض
  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
      ],
    );
  }
}