import 'dart:isolate';

import 'package:flutter/material.dart';

class ParallelForScreen extends StatefulWidget {
  const ParallelForScreen({super.key});

  @override
  State<ParallelForScreen> createState() => _ParallelForScreenState();
}

class _ParallelForScreenState extends State<ParallelForScreen> {
  final List<String> _consoleLogs = [];
  bool _isRunning = false;

  void _log(String msg) {
    setState(() => _consoleLogs.add(msg));
  }

  /// 🛠️ الدالة المحاكية لـ Main() والتي تطلق العمليات بالتوازي
  Future<void> _runParallelForSimulation() async {
    _consoleLogs.clear();
    setState(() => _isRunning = true);

    _log("🏁 Starting Parallel.For Engine Simulation...");
    int numberOfIterations = 8; // عدد الدورات المطلوب تنفيذها بالتوازي

    _log("📡 Spawning Isolated Tasks across available CPU Cores...\n");

    // تجهيز مصفوفة من الـ Futures لمحاكاة إطلاق الدورات كلها في نفس اللحظة بالتوازي
    List<Future<String>> parallelTasks = [];

    for (int i = 0; i < numberOfIterations; i++) {
      // ✅ تطبيق الدرس المعماري الصارم:
      // نمرر الدالة الحرة المستقلة تماماً كمعامل أول لـ Isolate.run، ونشحن الـ Index كمعامل صريح
      // لتفادي الـ Closure والـ ArgumentError كلياً.
      parallelTasks.add(Isolate.run(() => processIterationWorker(i)));
    }

    // انتظار اكتمال كافة الحلقات التكرارية المتوازية (تطابق نهاية سطر Parallel.For)
    final results = await Future.wait(parallelTasks);

    // طباعة المخرجات المستلمة من الأنوية الخلفية
    for (var logResult in results) {
      _log(logResult);
    }

    _log("\n🛑 All iterations completed successfully.");
    setState(() => _isRunning = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("⚡ Parallel.For Architectural Lab"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 129, 153, 209),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade800,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.tealAccent, width: 0.5),
              ),
              onPressed: _isRunning ? null : _runParallelForSimulation,
              icon: const Icon(Icons.repeat, color: Colors.tealAccent),
              label: const Text(
                "Execute Parallel.For (Index Based)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 25),

            // 🖥️ لوحة تتبع مخرجات معالجة الحلقات الرقمية
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF131824),
                  borderRadius: BorderRadius.circular(12),
                  //    border: BorderSide(color: Colors.tealAccent.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.terminal,
                              color: Colors.tealAccent,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Parallel Loop Thread Registry",
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        if (_isRunning)
                          const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.tealAccent,
                            ),
                          ),
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _consoleLogs.length,
                        itemBuilder: (context, index) {
                          String log = _consoleLogs[index];
                          Color col = Colors.white;
                          if (log.contains("Executing"))
                            col = Colors.amberAccent;
                          if (log.contains("completed") ||
                              log.contains("Engine"))
                            col = Colors.greenAccent;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              log,
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 12,
                                color: col,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
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
}

/// ⚙️ 🟢 الدالة التنفيذية الحرة المستقلة تماماً خارج الكلاس (Top-Level Function)
/// تطابق بدقة دالة static void ProcessIteration(int i) المذكورة في مذكرتك للسي شارب.
/// تأخذ الـ Index وتقوم بمحاكاة طحن المعالج المكثف ثم تعيد سجل التنفيذ.
String processIterationWorker(int i) {
  // محاكاة طحن معالج فيزيائي عبر حلقة تكرارية جافة (تطابق سطر تأخير العمل الحسابي)
  int sum = 0;
  for (int x = 0; x < 15000000; x++) {
    sum += x;
  }

  // الحصول على الهوية البرمجية الخاصة بالـ Isolate الحالي الذي نفذ العملية
  final String isolateId = Isolate.current.debugName ?? "Unknown_Isolate";

  return "⚙️ Executing iteration [$i] on background CPU Core ID: ($isolateId)";
}
