import 'dart:isolate';

import 'package:flutter/material.dart';

class BenchmarkScreen extends StatefulWidget {
  const BenchmarkScreen({super.key});

  @override
  State<BenchmarkScreen> createState() => _BenchmarkScreenState();
}

class _BenchmarkScreenState extends State<BenchmarkScreen> {
  String _currentModel = "خامل - في انتظار اختيار النموذج المعماري";
  final List<String> _logs = [];
  bool _isRunning = false;

  void _addLog(String msg) {
    setState(() => _logs.add(msg));
  }

  /// 🛑 1. النموذج المتزامن (Synchronous - Single Thread Blocking)
  void _executeSynchronous() {
    _logs.clear();
    setState(() {
      _isRunning = true;
      _currentModel = "🚨 النموذج المتزامن: جاري حجز وتجميد الخيط بالكامل!";
    });

    _addLog("⏳ [Step 1]: تشغيل مهمة متزامنة حاصرة...");
    // محاكاة عملية تستهلك المعالج وتمنع الواجهة من الحركة كليا
    // (ستلاحظ تجمد مؤشر التحميل الدوار فوراً)
    DateTime FutureTime = DateTime.now().add(const Duration(seconds: 3));
    while (DateTime.now().isBefore(FutureTime)) {
      // طحن متزامن حاصر للـ CPU
    }

    _addLog("✅ [Step 2]: اكتمل الطحن المتزامن بعد تجميد كامل للنظام.");
    setState(() {
      _isRunning = false;
      _currentModel = "تم الانتهاء مع حدوث شلل مؤقت للواجهة 🛑";
    });
  }

  /// ⚡ 2. النموذج غير المتزامن (Asynchronous - Non-blocking Event Driven)
  Future<void> _executeAsynchronous() async {
    _logs.clear();
    setState(() {
      _isRunning = true;
      _currentModel =
          "⚡ النموذج غير المتزامن: استغلال وقت الانتظار بذكاء (خيط واحد)";
    });

    _addLog("🚀 [Event Loop]: إطلاق طلب غير حاصر (I/O-Bound)...");

    // الانتظار هنا ذكي؛ الخيط الرئيسي يترك الدالة لتحديث الأنيميشن ويعود لاحقاً
    await Future.delayed(const Duration(seconds: 3));

    _addLog(
      "🎯 [Event Loop]: وصل الوعد (Future Completed) وتمت المعالجة بنجاح!",
    );
    setState(() {
      _isRunning = false;
      _currentModel = "اكتمل العمل بسلاسة 100% دون أدنى تشنج! ✨";
    });
  }

  /// 🧵 3. نموذج تعدد الخيوط المعزولة (Multithreading - Background Isolate)
  Future<void> _executeMultiThreading() async {
    _logs.clear();
    setState(() {
      _isRunning = true;
      _currentModel = "🧵 نموذج تعدد الخيوط: رمي عملية ثقيلة لمعالج خلفي مستقل";
    });

    _addLog(
      "📡 [Main Isolate]: ترحيل المهمة العنيفة لخيط خلفي معزول عن الـ UI...",
    );

    // إطلاق خيط خلفي حقيقي وجعل نظام التشغيل يجدول عمله بالتوازي
    ReceivePort mainReceivePort = ReceivePort();
    await Isolate.spawn(_backgroundWorker, mainReceivePort.sendPort);

    // انتظار النتيجة القادمة من الخيط الخلفي
    await mainReceivePort.first;

    _addLog("📥 [Main Isolate]: استلام إشارة الاكتمال من الخيط الخلفي بنجاح.");
    setState(() {
      _isRunning = false;
      _currentModel = "اكتمل العمل المتوازي الحقيقي على نواة أخرى! 🛠️";
    });
  }

  // الدالة التنفيذية للخيط المعزول الخلفي (The Isolated Multi-threaded Worker)
  static void _backgroundWorker(SendPort replyPort) {
    // طحن كثيف للـ CPU على خيط آخر بعيداً تماماً عن واجهة فلاتر
    DateTime FutureTime = DateTime.now().add(const Duration(seconds: 3));
    while (DateTime.now().isBefore(FutureTime)) {}

    // إرسال النتيجة فور انتهاء الطحن المادي
    replyPort.send("DONE");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📊 Concurrency & Async Laboratory"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 100, 126, 187),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusPanel(),
            const SizedBox(height: 20),

            // لوحة الأزرار المعمارية الثلاثية
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade900,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: _isRunning ? null : _executeSynchronous,
                    child: const Text(
                      "1. Sync",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: _isRunning ? null : _executeAsynchronous,
                    child: const Text(
                      "2. Async",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: _isRunning ? null : _executeMultiThreading,
                    child: const Text(
                      "3. MultiThread",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🖥️ لوحة الـ Terminal لمراقبة سلوك خيوط النظام
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF111622),
                  borderRadius: BorderRadius.circular(12),
                  //  border: BorderSide(color: Colors.cyanAccent.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.terminal,
                          color: Colors.cyanAccent,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Architecture Thread Execution Trace",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _logs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              _logs[index],
                              style: const TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
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

  Widget _buildStatusPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 76, 95, 141),
        borderRadius: BorderRadius.circular(12),
        //border: BorderSide(color: _isRunning ? Colors.amber.withOpacity(0.4) : Colors.cyanAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            _currentModel,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // 🔴 هذا المؤشر يثبت صحة المقارنة تاريخياً:
          // يتجمد تماماً في الخيار الأول (Sync).
          // يستمر في الحركة بسلاسة خارقة في الثاني والثالث (Async & MultiThread).
          const CircularProgressIndicator(color: Colors.cyanAccent),
        ],
      ),
    );
  }
}
