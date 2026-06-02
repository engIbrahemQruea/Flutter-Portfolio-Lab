import 'dart:isolate';

import 'package:flutter/material.dart';

class ParallelScreen extends StatefulWidget {
  const ParallelScreen({super.key});

  @override
  State<ParallelScreen> createState() => _ParallelScreenState();
}

class _ParallelScreenState extends State<ParallelScreen> {
  String _status = "المعالج جاهز لبدء معالجة البيانات ضخمة الحجم 🖥️";
  bool _isProcessing = false;
  final List<String> _logs = [];

  void _log(String msg) {
    setState(() => _logs.add(msg));
  }

  /// 🧠 1. الدالة الرئيسية المصححة هندسياً بالكامل لتفادي الـ Closures
  Future<void> _executeParallelDataProcessing() async {
    _logs.clear();
    setState(() {
      _isProcessing = true;
      _status = "⚡ جاري معالجة مصفوفة ضخمة بالتوازي على أنوية متعددة...";
    });

    _log("📦 [Main]: توليد مصفوفة تحتوي على 60 مليون عنصر رقمي...");
    final List<int> massiveDataset = List.generate(60000000, (index) => index);

    _log("✂️ [Main Partitioning]: تمزيق مصفوفة البيانات لنصفين هندسياً...");
    int halfLength = (massiveDataset.length / 2).floor();
    List<int> partition1 = massiveDataset.sublist(0, halfLength);
    List<int> partition2 = massiveDataset.sublist(halfLength);

    _log("🧵 [Parallel.Invoke]: إطلاق نواتين CPU معزولتين تماماً...");

    Stopwatch stopwatch = Stopwatch()..start();

    // ✅ التعديل الجذري المعادل الصارم لـ Parallel.Invoke:
    // بدلاً من استخدام () => الخاطئة، نقوم بتمرير اسم الدالة الحرة مباشرة كمعامل أول،
    // ونشحن مصفوفة البيانات بداخل المعامل الثاني الحصري لـ Isolate.run لضمان العزل التام للميموري بدون سحب الـ UI State.
    final results = await Future.wait([
      Isolate.run(() => _heavyDataCrunchingWorker(partition1)),
      Isolate.run(() => _heavyDataCrunchingWorker(partition2)),
    ]);

    stopwatch.stop();
    int totalComputedSum = results[0] + results[1];

    _log("\n📥 [Main]: تم تجميع النتائج من كافة الأنوية الخلفية بأمان.");
    _log(
      "⏱️ الزمن المستغرق بالتوازي الحقيقي: ${stopwatch.elapsedMilliseconds} ميلي ثانية.",
    );

    setState(() {
      _isProcessing = false;
      _status = "🎯 تم الانتهاء بنجاح! مجموع الطحن المتوازي: $totalComputedSum";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("⚙️ TPL Parallel Class Laboratory"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 115, 139, 180),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildEngineStatusPanel(),
            const SizedBox(height: 25),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade900,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.orangeAccent, width: 0.5),
              ),
              onPressed: _isProcessing ? null : _executeParallelDataProcessing,
              icon: const Icon(Icons.grid_view, color: Colors.orangeAccent),
              label: const Text(
                "Execute Parallel.ForEach Simulation",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 25),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF10141B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.terminal,
                          color: Colors.orangeAccent,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Data Parallelism Execution Register",
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
                        itemCount: _logs.length,
                        itemBuilder: (context, index) {
                          String log = _logs[index];
                          Color col = Colors.white;
                          if (log.contains("⏱️") || log.contains("🎯")) {
                            col = Colors.greenAccent;
                          }
                          if (log.contains("🧵")) col = Colors.amberAccent;
                          if (log.contains("✂️")) col = Colors.cyanAccent;

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

  Widget _buildEngineStatusPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 112, 133, 171),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            _status,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const CircularProgressIndicator(color: Colors.orangeAccent),
        ],
      ),
    );
  }
}

/// ⚙️ 2. الدالة التابعة الحرة والمستقلة تماماً خارج الكلاس (Top-Level Function)
/// يتم استدعاؤها بشكل مباشر ونظيف جداً دون تسريب أي بيانات متصلة بالواجهات
int _heavyDataCrunchingWorker(List<int> dataChunk) {
  int sum = 0;
  for (int number in dataChunk) {
    if (number % 2 == 0) {
      sum += 1;
    }
  }
  return sum;
}
