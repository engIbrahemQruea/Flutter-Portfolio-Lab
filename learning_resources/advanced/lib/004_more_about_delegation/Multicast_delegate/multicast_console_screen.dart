import 'package:advanced/004_more_about_delegation/Multicast_delegate/multicast_helper.dart';
import 'package:flutter/material.dart';

class MulticastConsoleScreen extends StatefulWidget {
  const MulticastConsoleScreen({super.key});

  @override
  State<MulticastConsoleScreen> createState() => _MulticastConsoleScreenState();
}

class _MulticastConsoleScreenState extends State<MulticastConsoleScreen> {
  final List<String> _consoleLogs = [];

  void _log(String text) {
    setState(() {
      _consoleLogs.add(text);
    });
  }

  // الدوال المطابقة لـ Method1 و Method2 بكود المدرب
  void _method1(String message) {
    _log("Method1: $message");
  }

  void _method2(String message) {
    _log("Method2: $message");
  }

  // محاكاة دالة الـ Main الحرفية للمدرب
  void _runMulticastSimulation() {
    setState(() => _consoleLogs.clear()); // تنظيف الكونسول

    // إنشاء كائن الـ Multicast الجاهز
    var myDelegate = DartMulticastDelegate();

    _log("--- الخطوة 1: ربط دالة 1 ودالة 2 (+=) ---");
    myDelegate.add(_method1); // تعادل myDelegate = Method1;
    myDelegate.add(_method2); // تعادل myDelegate += Method2;

    _log("👉 استدعاء الـ Delegate لأول مرة:");
    myDelegate.invoke("Hello, world!"); // التنفيذ الموحد

    _log("\n--- الخطوة 2: حذف دالة 1 (-=) ---");
    myDelegate.remove(_method1); // تعادل myDelegate -= Method1;

    _log("👉 استدعاء الـ Delegate لثاني مرة:");
    myDelegate.invoke("Another message.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('شاشة محاكاة الـ Multicast Delegate'),
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _runMulticastSimulation,
              icon: const Icon(Icons.bolt),
              label: const Text('تشغيل محاكاة كود المدرب الحرفي'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'مخرجات شاشة المحاكاة البرمجية:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(14),
                child: _consoleLogs.isEmpty
                    ? const Center(
                        child: Text(
                          'اضغط على الزر لتشغيل السيناريو التتابع...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _consoleLogs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              _consoleLogs[index],
                              style: const TextStyle(
                                color: Colors.lightGreenAccent,
                                fontFamily: 'monospace',
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
