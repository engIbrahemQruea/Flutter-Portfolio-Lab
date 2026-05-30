import 'package:flutter/material.dart';

class TaskFactoryScreen extends StatefulWidget {
  const TaskFactoryScreen({super.key});

  @override
  State<TaskFactoryScreen> createState() => _TaskFactoryScreenState();
}

///  المحاكاة المعمارية المخصصة للـ TaskFactory والـ CancellationToken
class FlutterTaskFactory {
  bool _isCanceled = false;

  void cancelAll() {
    _isCanceled = true;
  }

  /// دالة تحاكي بدقة دالة StartNew() في سي شارب
  Future<void> startNew(
    Future<void> Function() action,
    String taskName,
    Function(String) logCallback,
  ) async {
    if (_isCanceled) {
      logCallback(
        "🚫 [$taskName] Rejected: Factory Token is already canceled.",
      );
      return;
    }

    logCallback("🚀 [$taskName] is running (Inherited Factory Settings)...");

    try {
      await action();
      if (_isCanceled) {
        logCallback("🛑 [$taskName] Interrupted and Canceled before commit.");
      } else {
        logCallback("✅ [$taskName] completed successfully.");
      }
    } catch (e) {
      logCallback("❌ [$taskName] Throws Exception: ${e.toString()}");
    }
  }
}

class _TaskFactoryScreenState extends State<TaskFactoryScreen> {
  final List<String> _consoleLogs = [];
  bool _isFactoryActive = false;
  late FlutterTaskFactory _currentFactory;

  void _log(String msg) {
    setState(() => _consoleLogs.add(msg));
  }

  /// 🛠️ دالة التنفيذ الرئيسية المطابقة لكود الـ Main في C#
  Future<void> _runFactorySimulation() async {
    _consoleLogs.clear();
    setState(() {
      _isFactoryActive = true;
    });

    _log("🏁 Initializing Custom TaskFactory Context...");

    // إنشاء المصنع المركزي الجديد (تطابق سطر: TaskFactory taskFactory = new TaskFactory(...);)
    _currentFactory = FlutterTaskFactory();

    // إطلاق المهمة الأولى عبر المصنع (تطابق سطر: taskFactory.StartNew)
    Future<void> task1 = _currentFactory.startNew(
      () async {
        await Future.delayed(
          const Duration(seconds: 2),
        ); // محاكاة العمل Thread.Sleep(2000)
      },
      "Task 1",
      _log,
    );

    // إطلاق المهمة الثانية عبر نفس المصنع
    Future<void> task2 = _currentFactory.startNew(
      () async {
        await Future.delayed(
          const Duration(seconds: 1),
        ); // محاكاة العمل Thread.Sleep(1000)
      },
      "Task 2",
      _log,
    );

    try {
      // انتظار اكتمال كافة مهام المصنع (تطابق سطر: Task.WaitAll(task1, task2);)
      await Future.wait([task1, task2]);
      _log("\n🎯 All factory tasks resolved execution context.");
    } catch (e) {
      _log("⚠️ AggregateException caught in pipeline.");
    }

    setState(() {
      _isFactoryActive = false;
    });
  }

  /// 🛑 دالة إلغاء المهام فوراً عبر المصنع (Cancellation Trigger)
  void _triggerFactoryCancellation() {
    _currentFactory.cancelAll();
    _log(
      "\n🚨 [Emergency Switch]: CancellationTokenSource Triggered! All factory tasks signaling cancellation.",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🏛️ Task Factory & Token Blueprint"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 133, 158, 207),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade900,
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.blueAccent),
              ),
              onPressed: _isFactoryActive ? null : _runFactorySimulation,
              icon: const Icon(Icons.factory, color: Colors.blueAccent),
              label: const Text("Initialize & Launch Task Factory"),
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _isFactoryActive ? _triggerFactoryCancellation : null,
              icon: const Icon(Icons.cancel),
              label: const Text("Trigger Cancellation Token"),
            ),
            const SizedBox(height: 25),

            // 🖥️ لوحة الـ Monitor لعرض البيانات المتوارثة من المصنع
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF11151D),
                  borderRadius: BorderRadius.circular(12),
                  //  border: BorderSide(color: Colors.blueAccent.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          "TaskFactory Register Output",
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
                          Color col = Colors.white;
                          if (log.contains("✅") || log.contains("🎯"))
                            col = Colors.greenAccent;
                          if (log.contains("🚀")) col = Colors.cyanAccent;
                          if (log.contains("🚨") || log.contains("🚫"))
                            col = Colors.redAccent;

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
