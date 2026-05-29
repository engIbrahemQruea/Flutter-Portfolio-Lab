import 'package:flutter/material.dart';

class CounterLockScreen extends StatefulWidget {
  const CounterLockScreen({super.key});

  @override
  State<CounterLockScreen> createState() => _CounterLockScreenState();
}

class _CounterLockScreenState extends State<CounterLockScreen> {
  // المورد المشترك (المعادل لـ sharedCounter)
  int _sharedCounter = 0;

  // 🛡️ الحارس المعماري الافتراضي (المعادل لـ lockObject و lock statement)
  bool _isLockHeld = false;

  final List<String> _consoleLogs = [];
  bool _isSimulationRunning = false;

  void _log(String message) {
    setState(() {
      _consoleLogs.add(message);
    }); 
  }

  /// 🔓 دالة محاكاة الدخول للمنطقة الحرجة باستخدام قفل برمجى (Simulated Lock Entry)
  Future<void> _safeIncrement(String taskName) async {
    // 1. التنافس على حجز القفل (Attempting to acquire lock)
    while (_isLockHeld) {
      // إذا كان القفل محجوزاً، تنتظر الدالة الدورة القادمة لحلقة الأحداث
      // هذا يحاكي تماما تجميد الخيط في C# ولكن بأسلوب ذكي غير حاصر للشاشة
      await Future.delayed(const Duration(milliseconds: 5));
    }

    // 2. حجز القفل بنجاح (Lock Acquired)
    _isLockHeld = true;
    _log("🔒 [$taskName] Acquired Virtual Lock. Entering Critical Section...");

    try {
      // المنطقة الحرجة (Critical Section)
      // محاكاة قراءة وتعديل وكتابة المورد المشترك عبر تأخير صغير
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _sharedCounter++;
      });
      _log("⚙️ [$taskName] Updated Shared Counter to: $_sharedCounter");
    } finally {
      // 3. تحرير القفل إلزامياً (Lock Released)
      _isLockHeld = false;
      _log("🔓 [$taskName] Released Virtual Lock. Exiting Critical Section.\n");
    }
  }

  /// 🛠️ خط الإنتاج لتشغيل المحاكاة وإطلاق المهام المتنافسة بالتوازي
  void _runSimulation() async {
    setState(() {
      _isSimulationRunning = true;
      _sharedCounter = 0;
      _consoleLogs.clear();
    });

    _log("🚀 Starting Task 1 and Task 2 simultaneously...");

    // إطلاق قنوات معالجة متنافسة بشكل متوازٍ غير متزامن
    // كل مهمة ستحاول زيادة العداد 5 مرات، وتتنافس على الـ Lock
    Future<void> task1Pipeline() async {
      for (int i = 0; i < 5; i++) {
        await _safeIncrement("Task 1 (Thread Alpha)");
      }
    }

    Future<void> task2Pipeline() async {
      for (int i = 0; i < 5; i++) {
        await _safeIncrement("Task 2 (Thread Beta)");
      }
    }

    // 🔴 تشغيل المسارين معاً بالتوازي التام (Concurrent Execution)
    // بفضل الـ Virtual Lock، ستلاحظ تتابع وتنظيم الدخول للمنطقة الحرجة بدون تداخل فاسد
    await Future.wait([task1Pipeline(), task2Pipeline()]);

    _log(
      "🎯 Simulation Complete! Final Counter Value: $_sharedCounter (Expected: 10)",
    );
    setState(() {
      _isSimulationRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🛡️ Sync Lock Architectural Lab"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 128, 147, 191),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCounterWidget(),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade800,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
              ),
              onPressed: _isSimulationRunning ? null : _runSimulation,
              icon: const Icon(Icons.lock_clock, color: Colors.cyanAccent),
              label: const Text(
                "Execute Mutex Lock Simulation",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // 🖥️ لوحة الـ Console الحية التي تعكس حركة الكود
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
                          "Deterministic Lock Trace Logs",
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
                        itemCount: _consoleLogs.length,
                        itemBuilder: (context, index) {
                          String log = _consoleLogs[index];
                          Color txtColor = Colors.white;
                          if (log.contains("Acquired"))
                            txtColor = Colors.amberAccent;
                          if (log.contains("Released"))
                            txtColor = Colors.greenAccent;
                          if (log.contains("Task 1"))
                            txtColor = Colors.cyanAccent;
                          if (log.contains("Task 2"))
                            txtColor = Colors.purpleAccent;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              log,
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 12,
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

  Widget _buildCounterWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 36, 47, 74),
        borderRadius: BorderRadius.circular(12),
        //  border: BorderSide(color: Colors.cyanAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Text(
            "SHARED COUNTER REGISTER VALUE",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "$_sharedCounter",
            style: const TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.bold,
              fontFamily: 'Courier',
              color: Colors.cyanAccent,
            ),
          ),
        ],
      ),
    );
  }
}
