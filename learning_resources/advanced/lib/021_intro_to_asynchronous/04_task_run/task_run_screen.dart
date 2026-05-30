import 'dart:isolate';

import 'package:flutter/material.dart';

class TaskRunScreen extends StatefulWidget {
  const TaskRunScreen({super.key});

  @override
  State<TaskRunScreen> createState() => _TaskRunScreenState();
}

class _TaskRunScreenState extends State<TaskRunScreen> {
  String _engineStatus = "المعالج خامل.. اختر استراتيجية التنفيذ 🖥️";
  bool _isComputing = false;
  final List<String> _executionTrace = [];

  void _log(String msg) {
    setState(() => _executionTrace.add(msg));
  }

  /// ❌ 1. الطحن الخاطئ على خيط الواجهة (Main UI Thread Heavy Work - Bad Practice)
  void _runHeavyWorkOnUIThread() {
    _executionTrace.clear();
    setState(() {
      _isComputing = true;
      _engineStatus = "🚨 طحن عنيف على خيط الـ UI.. الشاشة ستتجمد الآن كلياً!";
    });

    _log("🔴 [UI Thread]: بدء طحن المعالج تزامناً...");

    // سطر ميكانيكي يطحن المعالج لمليارات الدورات (CPU-Bound Task)
    int result = _heavyCpuHeavyTask(500000000);

    _log("🟢 [UI Thread]: انتهى الطحن. النتيجة: $result");
    setState(() {
      _isComputing = false;
      _engineStatus = "اكتمل الطحن ولكن بعد شلل تام للأنيميشن والواجهة!";
    });
  }

  /// 🛡️ 2. الترجمة المعمارية المطابقة لـ Task.Run (Offloading to Background Isolate)
  Future<void> _runHeavyWorkAsynchronously() async {
    _executionTrace.clear();
    setState(() {
      _isComputing = true;
      _engineStatus =
          "⚡ محاكاة Task.Run: ترحيل المهمة العنيفة لنواة CPU أخرى عبر Isolate";
    });

    _log("🚀 [Main Isolate]: ترحيل كود الطحن فوراً لخيط خلفي معزول...");

    // 🔴 المربع الإعجازي المعادل لـ Task.Run في C#
    // Isolate.run تقوم بفتح خيط جديد، تشغيل الدالة العنيفة عليه، وإعادة النتيجة هنا دون مساس بـ سلاسة الشاشة
    int result = await Isolate.run(() => _heavyCpuHeavyTask(500000000));

    _log("✅ [Main Isolate]: استلام النتيجة الصافية من النواة الخلفية: $result");
    setState(() {
      _isComputing = false;
      _engineStatus =
          "🎯 نجاح باهر! تمت معالجة البيانات وبقيت الواجهة رشيفة 100%!";
    });
  }

  /// ⚙️ الدالة العنيفة التي تطحن الـ CPU (Compute-Intensive Function)
  static int _heavyCpuHeavyTask(int iterations) {
    int count = 0;
    for (int i = 0; i < iterations; i++) {
      count += i;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🧬 Task.Run & Isolate Architecture"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 145, 166, 213),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildEngineStatusPanel(),
            const SizedBox(height: 25),

            // زر التجربة الخاطئة
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _isComputing ? null : _runHeavyWorkOnUIThread,
              icon: const Icon(Icons.error_outline),
              label: const Text("Block UI (Heavy Work on Main Thread)"),
            ),
            const SizedBox(height: 12),

            // زر التجربة الهندسية العبقرية (Task.Run / Isolate.run)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan.shade800,
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
              ),
              onPressed: _isComputing ? null : _runHeavyWorkAsynchronously,
              icon: const Icon(Icons.memory, color: Colors.cyanAccent),
              label: const Text(
                "Task.Run Mirror (Offload to Background Isolate)",
              ),
            ),
            const SizedBox(height: 25),

            // 🖥️ لوحة المراقبة والمعاينة الفورية لحالة الخيوط
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF10141D),
                  borderRadius: BorderRadius.circular(12),
                  //   border: BorderSide(color: Colors.cyanAccent.withOpacity(0.2)),
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
                          "CPU Core Scheduling Register",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _executionTrace.length,
                        itemBuilder: (context, index) {
                          String log = _executionTrace[index];
                          Color col = log.contains("🔴")
                              ? Colors.redAccent
                              : Colors.cyanAccent;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              log,
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 13,
                                color: col,
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

  Widget _buildEngineStatusPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 85, 102, 144),
        borderRadius: BorderRadius.circular(12),
        //  border: BorderSide(color: _isComputing ? Colors.amber.withOpacity(0.4) : Colors.cyanAccent.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            _engineStatus,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // 🛑 هذا المؤشر الدوار هو الفيصل التجريبي:
          // عند اختيار الخيار الأول، سيتجمد عن الدوران تماماً كدليل مادي على شلل خيط الـ UI.
          // عند اختيار الخيار الثاني، يستمر في الدوران المذيب والسلس لأن العمل نُقل لمعالج آخر!
          const CircularProgressIndicator(color: Colors.cyanAccent),
        ],
      ),
    );
  }
}
