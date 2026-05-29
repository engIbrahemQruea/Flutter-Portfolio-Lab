import 'dart:isolate';

import 'package:flutter/material.dart';

/// 🏛️ هيكل البيانات (Data Class) المستخدم لتجميع البارامترات بشكل آمن معمارياً
/// المعادل البرمجي للفّ البيانات قبل إرسالها للخيط الخلفي
class ThreadArguments {
  final String messageToPrint;
  final int repeatCount;
  final SendPort replyPort; // بوابة إعادة النتيجة للـ UI Thread

  ThreadArguments({
    required this.messageToPrint,
    required this.repeatCount,
    required this.replyPort,
  });
}

class ParameterizedScreen extends StatefulWidget {
  const ParameterizedScreen({super.key});

  @override
  State<ParameterizedScreen> createState() => _ParameterizedScreenState();
}

//class _NavigatorState extends State<ParameterizedScreen> {}

class _ParameterizedScreenState extends State<ParameterizedScreen> {
  final TextEditingController _textController = TextEditingController(
    text: "Abu-Hadhoud Core",
  );
  int _counter = 5;
  final List<String> _resultsLogs = [];
  bool _isProcessing = false;

  late ReceivePort _uiReceivePort;

  /// 🛠️ الميثود السيادية لإطلاق الخيط وتمرير البارامترات له (The Spawn Pipeline)
  void _spawnParameterizedThread() async {
    setState(() {
      _isProcessing = true;
      _resultsLogs.clear();
      _resultsLogs.add(
        "🧵 [UI Isolate]: جاري تجميع البارامترات وتهيئة الخيط الجديد...",
      );
    });

    // 1. إنشاء منفذ الاستقبال الخاص بالواجهة
    _uiReceivePort = ReceivePort();

    // 2. تجميع البارامترات داخل الكائن المحمي للأنواع (Arguments Instance)
    final args = ThreadArguments(
      messageToPrint: _textController.text,
      repeatCount: _counter,
      replyPort: _uiReceivePort.sendPort, // نرسل له بوابتنا ليرد علينا
    );

    // 3. إطلاق الخيط المعزول الحقيقي وتمرير كائن البارامترات له مباشرة
    // الإطلاق هنا محمي تماماً؛ والذاكرة يتم نسخها لضمان عدم حدوث Race Condition
    await Isolate.spawn(_backgroundWorkerEntry, args);

    // 4. الاستماع للمخرجات القادمة من الخيط الخلفي وعرضها حياً
    _uiReceivePort.listen((dynamic message) {
      if (message == "DONE") {
        setState(() => _isProcessing = false);
        _uiReceivePort.close(); // إغلاق المنفذ فور انتهاء العملية
      } else {
        setState(() => _resultsLogs.add(message.toString()));
      }
    });
  }

  /// ⚙️ الدالة التنفيذية للخيط المعزول (The Background Thread Entrypoint)
  /// كقاعدة معمارية صلبة: يجب أن تكون Static وتستقبل نوع البارامتر المخصص بدقة
  static void _backgroundWorkerEntry(ThreadArguments args) async {
    // الخيط الخلفي يستلم البارامترات جاهزة ومحمية الأنواع دون الحاجة لـ Casting أعمى!
    for (int i = 1; i <= args.repeatCount; i++) {
      // محاكاة معالجة بيانات مكثفة وتأخير ثانية واحدة
      await Future.delayed(const Duration(seconds: 1));

      // بث النتيجة تلو الأخرى عبر البوابة إلى الخيط الرئيسي للواجهة
      args.replyPort.send(
        "🗂️ Background Worker [Iteration $i]: Processing '${args.messageToPrint}'",
      );
    }

    // إخطار الواجهة بانتهاء العمل وموت الخيط الخلفي
    args.replyPort.send("DONE");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("⚡ Parameterized Thread Lab"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 85, 109, 155),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // لوحة مدخلات المستخدم (البارامترات المراد إرسالها للخيط)
            _buildInputCard(),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 155, 197, 192),
                padding: const EdgeInsets.symmetric(vertical: 14),
                disabledBackgroundColor: Colors.grey.shade800,
              ),
              onPressed: _isProcessing ? null : _spawnParameterizedThread,
              icon: _isProcessing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.cyclone),
              label: Text(
                _isProcessing
                    ? "Processing in Background..."
                    : "Execute Parameterized Thread",
              ),
            ),
            const SizedBox(height: 20),

            // 🖥️ مرآة شاشة المخرجات (Console Output)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF181E29),
                  borderRadius: BorderRadius.circular(12),
                  // border: BorderSide(color: Colors.teal.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Thread Processing Stream",
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
                        itemCount: _resultsLogs.length,
                        itemBuilder: (context, index) {
                          String log = _resultsLogs[index];
                          Color txtColor = log.contains("Background")
                              ? Colors.tealAccent
                              : Colors.white;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
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

  Widget _buildInputCard() {
    return Card(
      color: const Color.fromARGB(255, 157, 178, 216),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📥 Thread Parameters Input:",
              style: TextStyle(
                color: Colors.tealAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "Message Parameter (string)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Repeat Parameter (int):",
                  style: TextStyle(fontSize: 14),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: _counter > 1
                          ? () => setState(() => _counter--)
                          : null,
                    ),
                    Text(
                      "$_counter",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () => setState(() => _counter++),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
