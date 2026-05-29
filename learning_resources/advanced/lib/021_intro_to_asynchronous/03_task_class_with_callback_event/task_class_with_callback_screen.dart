import 'package:flutter/material.dart';

class EventCallbackScreen extends StatefulWidget {
  const EventCallbackScreen({super.key});

  @override
  State<EventCallbackScreen> createState() => _EventCallbackScreenState();
}

/// 📦 1. البديل المعماري لـ CustomEventArgs في سي شارب
class CustomEventData {
  final int parameter1;
  final String parameter2;

  CustomEventData(this.parameter1, this.parameter2);
}

/// 📜 2. تعريف الـ Callback Signature (البديل للـ delegate في سي شارب)
typedef CallbackEventHandler = void Function(CustomEventData data);

class _EventCallbackScreenState extends State<EventCallbackScreen> {
  final List<String> _consoleLogs = [];
  bool _isTaskRunning = false;

  void _printToConsole(String text) {
    setState(() {
      _consoleLogs.add(text);
    });
  }

  /// 🛠️ دالة المحاكاة الرئيسية (تطابق دالة Main)
  Future<void> _runMainFlow() async {
    setState(() {
      _isTaskRunning = true;
      _consoleLogs.clear();
    });

    _printToConsole("Starting execution inside Main...");

    // 🔴 ربط وتمرير الـ Callback (تطابق سطر: Task performTask = PerformAsyncOperation(CallbackEvent);)
    // هنا نمرر دالة _onCallbackReceived مباشرة كمعامل!
    Future<void> performTask = _performAsyncOperation(_onCallbackReceived);

    _printToConsole("Doing some other UI layout rendering work...");

    // انتظار انتهاء التاسك بالكامل
    await performTask;

    _printToConsole("Done!");
    setState(() {
      _isTaskRunning = false;
    });
  }

  /// ⚙️ الدالة الخلفية غير المتزامنة التي تطلق الحدث (تطابق PerformAsyncOperation)
  Future<void> _performAsyncOperation(CallbackEventHandler callback) async {
    // محاكاة عملية تأخير (تطابق سطر: await Task.Delay(2000);)
    await Future.delayed(const Duration(seconds: 2));

    // إنشاء كائن البيانات (تطابق سطر: CustomEventArgs eventArgs = new CustomEventArgs(42, "Hello from event");)
    CustomEventData eventData = CustomEventData(42, "Hello from Flutter Event Callback!");

    // 🎯 تفعيل النداء الراجع وإرسال البيانات فوراً (تطابق سطر: callback?.Invoke(null, eventArgs);)
    callback(eventData);
  }

  /// 📥 الدالة المستمعة للحدث (تطابق OnCallbackReceived)
  void _onCallbackReceived(CustomEventData e) {
    _printToConsole("\n📥 [Event Received Successfully]:");
    _printToConsole("📍 Parameter 1 (ID): ${e.parameter1}");
    _printToConsole("📍 Parameter 2 (Msg): ${e.parameter2}\n");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📡 Event Callback Architecture"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 132, 149, 203),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.deepPurpleAccent),
              ),
              onPressed: _isTaskRunning ? null : _runMainFlow,
              icon: const Icon(Icons.settings_input_component, color: Colors.deepPurpleAccent),
              label: Text(_isTaskRunning ? "Awaiting Callback Event..." : "Trigger Async Task With Callback"),
            ),
            const SizedBox(height: 25),

            // 🖥️ لوحة تتبع مخرجات الحدث والـ Console
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF121727),
                  borderRadius: BorderRadius.circular(12),
                //  border: BorderSide(color: Colors.deepPurpleAccent.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.terminal, color: Colors.deepPurpleAccent, size: 18),
                            SizedBox(width: 8),
                            Text("Event-Driven Architecture Log", style: TextStyle(fontFamily: 'Courier', fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                        if (_isTaskRunning)
                          const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.deepPurpleAccent))
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _consoleLogs.length,
                        itemBuilder: (context, index) {
                          String log = _consoleLogs[index];
                          Color txtColor = Colors.white;
                          if (log.contains("Parameter")) txtColor = Colors.greenAccent;
                          if (log.contains("Received")) txtColor = Colors.amberAccent;
                          if (log.contains("Starting")) txtColor = Colors.cyanAccent;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              log,
                              style: TextStyle(fontFamily: 'Courier', fontSize: 13, color: txtColor, fontWeight: FontWeight.bold, height: 1.3),
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