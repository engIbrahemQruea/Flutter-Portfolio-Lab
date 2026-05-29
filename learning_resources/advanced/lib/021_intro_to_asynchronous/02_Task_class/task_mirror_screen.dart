import 'package:flutter/material.dart';

class TaskMirrorScreen extends StatefulWidget {
  const TaskMirrorScreen({super.key});

  @override
  State<TaskMirrorScreen> createState() => _TaskMirrorScreenState();
}

class _TaskMirrorScreenState extends State<TaskMirrorScreen> {
  final List<String> _consoleOutput = [];
  bool _isProcessing = false;

  void _printToConsole(String text) {
    setState(() {
      _consoleOutput.add(text);
    });
  }

  /// 🛠️ الترجمة الهندسية الدقيقة لدالة Main() غير المتزامنة في C#
  Future<void> _executeMainTask() async {
    setState(() {
      _isProcessing = true;
      _consoleOutput.clear();
    });

    _printToConsole("🚀 [Main]: Starting async execution flow...");

    // 1. إنشاء وتشغيل المهمة غير المتزامنة (تطابق سطر: Task<int> resultTask = PerformAsyncOperation();)
    // المهمة تنطلق الآن حركياً في كواليس الـ Event Loop
    Future<int> resultTask = _performAsyncOperation();

    // 2. القيام بأعمال أخرى أثناء انتظار المهمة (تطابق سطر: Console.WriteLine("Doing some other work...");)
    _printToConsole(
      "💻 [Main]: Doing some other UI rendering work while task runs...",
    );
    _printToConsole(
      "🎨 [Main]: Flutter can animate and respond to user inputs perfectly right now.",
    );

    // 3. انتظار النتيجة واستردادها (تطابق سطر: int result = await resultTask;)
    // الكود يقف هنا منطقياً، والـ UI مستمر في الدوران بسلاسة
    int result = await resultTask;

    // 4. معالجة النتيجة وطباعتها
    _printToConsole("\n📥 [Main]: Received completed value from the Future.");
    _printToConsole(
      "🎯 Result: $result (The Answer to Life, the Universe, and Everything)",
    );

    setState(() {
      _isProcessing = false;
    });
  }

  /// ⚙️ الدالة التي تحاكي الـ Task<int> (تطابق دالة: PerformAsyncOperation())
  Future<int> _performAsyncOperation() async {
    _printToConsole(
      "⏳ [Task]: Simulated async background operation started...",
    );

    // محاكاة تأخير غير حاصر لمدة ثانيتين (تطابق سطر: await Task.Delay(2000);)
    await Future.delayed(const Duration(seconds: 2));

    _printToConsole("✅ [Task]: Async work complete! Returning payload...");
    return 42; // إعادة النتيجة للـ Future
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("💎 .NET Task Class Mirror in Flutter"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 110, 128, 201),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 91, 152, 221),
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.blueAccent),
              ),
              onPressed: _isProcessing ? null : _executeMainTask,
              icon: const Icon(
                Icons.play_circle_filled,
                color: Colors.blueAccent,
              ),
              label: Text(
                _isProcessing
                    ? "Task Pipeline Executing..."
                    : "Run Async Main() Lab Simulation",
              ),
            ),
            const SizedBox(height: 25),

            // 🖥️ شاشة الـ Console التوضيحية لخط سير المعالجة
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF161B2E),
                  borderRadius: BorderRadius.circular(12),
                  //border: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
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
                              color: Colors.blueAccent,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "TPL & Future Parallel Pipeline Trace",
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        if (_isProcessing)
                          const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blueAccent,
                            ),
                          ),
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _consoleOutput.length,
                        itemBuilder: (context, index) {
                          String log = _consoleOutput[index];
                          Color txtColor = Colors.white;
                          if (log.contains("Result"))
                            txtColor = Colors.greenAccent;
                          if (log.contains("[Task]"))
                            txtColor = Colors.amberAccent;
                          if (log.contains("[Main]"))
                            txtColor = Colors.cyanAccent;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              log,
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 13,
                                color: txtColor,
                                height: 1.3,
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
