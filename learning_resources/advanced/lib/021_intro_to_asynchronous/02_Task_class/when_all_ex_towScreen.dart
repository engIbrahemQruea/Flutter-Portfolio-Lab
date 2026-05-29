import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WhenAllScreen extends StatefulWidget {
  const WhenAllScreen({super.key});

  @override
  State<WhenAllScreen> createState() => _WhenAllScreenState();
}

class _WhenAllScreenState extends State<WhenAllScreen> {
  final List<String> _consoleLogs = [];
  bool _isEngineRunning = false;

  void _printToConsole(String message) {
    setState(() {
      _consoleLogs.add(message);
    });
  }

  /// 🛠️ الترجمة المعمارية المطابقة لدالة Main() غير المتزامنة باستخدام Future.wait
  Future<void> _executeParallelTasks() async {
    setState(() {
      _isEngineRunning = true;
      _consoleLogs.clear();
    });

    _printToConsole("Starting tasks...");

    // 1. إطلاق المهام الثلاثة معاً بالتوازي (لا نضع await هنا لأننا نريدهم أن ينطلقوا معاً)
    Future<void> task1 = _downloadAndPrintAsync(
      "https://www.cnn.com",
      "Task 1",
    );
    _printToConsole("Task 1 started...");

    Future<void> task2 = _downloadAndPrintAsync(
      "https://www.amazon.com",
      "Task 2",
    );
    _printToConsole("Task 2 started...");

    Future<void> task3 = _downloadAndPrintAsync(
      "https://www.programmingadvices.com",
      "Task 3",
    );
    _printToConsole("Task 3 started...\n");

    // 🔴 المربع السحري المقابل لـ await Task.WhenAll(...)
    // ننتظر اكتمال القائمة بالكامل بشكل ذكي وغير حاصر للـ UI
    await Future.wait([task1, task2, task3]);

    // السطور التالية لن تنفذ إلا بعد نجاح/اكتمال الثلاثة تماماً
    _printToConsole("\nDone, all tasks finished execution.");

    setState(() {
      _isEngineRunning = false;
    });
  }

  /// ⚙️ الدالة غير المتزامنة لتحميل البيانات (تطابق DownloadAndPrintAsync)
  Future<void> _downloadAndPrintAsync(String url, String taskName) async {
    try {
      // محاكاة عمل وتأخير صغير (تطابق سطر: await Task.Delay(100);)
      await Future.delayed(const Duration(milliseconds: 100));

      // طلب جلب البيانات الفعلي عبر الشبكة غير الحاصرة
      final response = await http.get(Uri.parse(url));

      _printToConsole(
        "📡 $url: ${response.body.length} characters downloaded via $taskName",
      );
    } catch (e) {
      _printToConsole("❌ $url: Failed to download via $taskName");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("⚡ Task.WhenAll Matrix Mirror"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 99, 128, 186),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 150, 162, 240),
                padding: const EdgeInsets.symmetric(vertical: 16),
                disabledBackgroundColor: const Color.fromARGB(
                  255,
                  185,
                  181,
                  181,
                ),
              ),
              onPressed: _isEngineRunning ? null : _executeParallelTasks,
              icon: _isEngineRunning
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.flash_on, color: Colors.amberAccent),
              label: Text(
                _isEngineRunning
                    ? "AWAITING WHEN_ALL..."
                    : "Run Aggregated Tasks Simulation",
              ),
            ),
            const SizedBox(height: 20),

            // 🖥️ لوحة عرض تتبع المخرجات الحية (Console)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF121824),
                  borderRadius: BorderRadius.circular(12),
                  //  border: BorderSide(color: Colors.indigoAccent.withOpacity(0.3)),
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
                              color: Colors.indigoAccent,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "C# Task Console Output Emulator",
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        if (_isEngineRunning)
                          const Text(
                            "⚡ AGGREGATING",
                            style: TextStyle(
                              fontFamily: 'Courier',
                              color: Colors.amberAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
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
                          Color txtColor = Colors.white;
                          if (log.contains("Done"))
                            txtColor = Colors.greenAccent;
                          if (log.contains("Starting"))
                            txtColor = Colors.cyanAccent;
                          if (log.contains("Task 1"))
                            txtColor = Colors.purpleAccent;
                          if (log.contains("Task 2"))
                            txtColor = Colors.pinkAccent;
                          if (log.contains("Task 3"))
                            txtColor = Colors.yellowAccent;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              log,
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 13,
                                color: txtColor,
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
}
