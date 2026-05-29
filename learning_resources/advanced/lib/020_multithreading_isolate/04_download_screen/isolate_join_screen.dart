import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IsolateJoinScreen extends StatefulWidget {
  const IsolateJoinScreen({super.key});

  @override
  State<IsolateJoinScreen> createState() => _IsolateJoinScreenState();
}

class _IsolateJoinScreenState extends State<IsolateJoinScreen> {
  final List<String> _consoleLogs = [];
  bool _isWorking = false;

  void _log(String message) {
    setState(() {
      _consoleLogs.add(message);
    });
  }

  /// 🛠️ الأنبوب الهندسي لمحاكاة Thread.Join() بالتوازي غير الحاصر
  Future<void> _executeThreadsWithJoin() async {
    setState(() {
      _isWorking = true;
      _consoleLogs.clear();
    });

    _log("🚀 Starting threads (Futures)...");

    // تجهيز المهام الثلاثة للعمل في نفس الوقت
    final task1 = _downloadAndPrint("https://www.cnn.com", "Thread 1");
    _log("📡 Thread 1 started...");

    final task2 = _downloadAndPrint("https://www.amazon.com", "Thread 2");
    _log("📡 Thread 2 started...");

    final task3 = _downloadAndPrint("https://www.programmingadvices.com", "Thread 3");
    _log("📡 Thread 3 started...\n");

    // 🔴 المقابل المعماري لـ t1.Join(); t2.Join(); t3.Join();
    // الانتظار هنا "ذكي وغير حاصر"؛ الشاشة مستمرة في الدوران والأنيميشن طائر بسلاسة
    await Future.wait([task1, task2, task3]);

    // هذا السطر لن يصله التنفيذ إلا بعد اكتمال الثلاثة تماماً (تماما مثل سلوك الـ Join)
    _log("\n🛑 Done all threads finished execution.");
    
    setState(() {
      _isWorking = false;
    });
  }

  /// الدالة الخلفية التي تحاكي تحميل وطباعة البيانات
  Future<void> _downloadAndPrint(String url, String threadName) async {
    try {
      // محاكاة تأخير العمل البرمجي الصغير (Thread.Sleep(100))
      await Future.delayed(const Duration(milliseconds: 100));

      // جلب البيانات الفعلي من الشبكة
      final response = await http.get(Uri.parse(url));
      
      _log("✅ $url: ${response.body.length} characters downloaded via $threadName");
    } catch (e) {
      _log("❌ $url: Failed to download via $threadName ($e)");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("⚙️ Thread.Join() Sync Matrix"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 126, 165, 220),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
                disabledBackgroundColor: Colors.grey.shade900,
              ),
              onPressed: _isWorking ? null : _executeThreadsWithJoin,
              icon: _isWorking 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.merge_type),
              label: Text(_isWorking ? "Waiting for Joins..." : "Run Thread Join Simulation"),
            ),
            const SizedBox(height: 20),

            // 🖥️ مرآة الـ Console الخاصة بـ C# مع الأنيميشن الحي للفلاتر
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF161B22),
                  borderRadius: BorderRadius.circular(12),
                 // border: BorderSide(color: Colors.deepOrange.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.terminal, color: Colors.deepOrangeAccent, size: 18),
                            SizedBox(width: 8),
                            Text("C# Console Execution Trace", style: TextStyle(fontFamily: 'Courier', fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                        if (_isWorking)
                          const Text("⏳ BLOCKED WAITING", style: TextStyle(fontFamily: 'Courier', color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _consoleLogs.length,
                        itemBuilder: (context, index) {
                          String log = _consoleLogs[index];
                          Color txtColor = Colors.white;
                          if (log.contains("Done all")) txtColor = Colors.greenAccent;
                          if (log.contains("Starting")) txtColor = Colors.cyanAccent;
                          if (log.contains("Thread 1")) txtColor = Colors.purpleAccent;
                          if (log.contains("Thread 2")) txtColor = Colors.pinkAccent;
                          if (log.contains("Thread 3")) txtColor = Colors.yellowAccent;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              log,
                              style: TextStyle(fontFamily: 'Courier', fontSize: 13, color: txtColor, fontWeight: FontWeight.bold),
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