import 'package:flutter/material.dart';

class GuardLabScreen extends StatefulWidget {
  const GuardLabScreen({super.key});

  @override
  State<GuardLabScreen> createState() => _GuardLabScreenState();
}

class _GuardLabScreenState extends State<GuardLabScreen> {
  int _secureCounter = 0;
  final List<String> _eventHistory = [];
  bool _isRunning = false;

  void _logEvent(String log) {
    setState(() {
      _eventHistory.insert(0, log); // إدراج الحدث في أعلى القائمة
    });
  }

  /// 🛠️ محاكاة إطلاق مئات الطلبات المتوازية لمحاولة إحداث Race Condition
  void _triggerMassiveConcurrentUpdates() async {
    setState(() {
      _isRunning = true;
      _secureCounter = 0;
      _eventHistory.clear();
    });

    _logEvent("🚀 انطلاق 1000 طلب تحديث في نفس اللحظة...");

    // محاكاة إرسال 1000 حدث عبر الـ Event Loop
    // في لغة أخرى تتقاسم الذاكرة، هذا الكود سيفسد الداتا تماماً بدون Locks يدوية.
    // في دارت وفلاتر، حلقة الأحداث تضمن الذرية (Atomicity) لأن التنفيذ على خيط واحد متسلسل المهام.
    for (int i = 1; i <= 1000; i++) {
      // نستخدم Future.minimal لتوزيع الطلبات عبر طابور الأحداث (Event Queue)
      Future.microtask(() {
        setState(() {
          _secureCounter++;
        });
        if (i % 200 == 0) {
          _logEvent("📥 طابور الأحداث معالجة الدفعة: [$i طلب].. العداد الآن: $_secureCounter");
        }
        
        if (_secureCounter == 1000) {
          setState(() => _isRunning = false);
          _logEvent("🎯 اكتملت المنظومة! النتيجة: $_secureCounter/1000 صلبة ومحمية بنسبة 100%!");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🛡️ Anti-Race Condition Sandbox"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 106, 138, 220),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // لوحة عرض حالة العداد المركزي المحمي
            _buildCounterDisplay(),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
                disabledBackgroundColor: Colors.grey.shade900,
              ),
              onPressed: _isRunning ? null : _triggerMassiveConcurrentUpdates,
              icon: const Icon(Icons.shield),
              label: Text(_isRunning ? "Processing Sequentially..." : "Attack Counter with 1000 Events"),
            ),
            const SizedBox(height: 20),

            // 🖥️ لوحة تتبع طابور الأحداث (Event Queue Visualizer)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF111726),
                  borderRadius: BorderRadius.circular(12),
                 // border: BorderSide(color: Colors.greenAccent.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.rule, color: Colors.greenAccent, size: 18),
                        SizedBox(width: 8),
                        Text("Dart Event Queue Stream (Deterministic)", style: TextStyle(fontFamily: 'Courier', fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _eventHistory.length,
                        itemBuilder: (context, index) {
                          String log = _eventHistory[index];
                          Color txtColor = log.contains("🎯") ? Colors.greenAccent : Colors.white;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              log,
                              style: TextStyle(fontFamily: 'Courier', fontSize: 12, color: txtColor, height: 1.4),
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

  Widget _buildCounterDisplay() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111726),
        borderRadius: BorderRadius.circular(12),
        //border: BorderSide(color: _isRunning ? Colors.amber.withOpacity(0.4) : Colors.greenAccent.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          const Text("SHARED RESOURCE VALUE", style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1.5)),
          const SizedBox(height: 10),
          Text(
            "$_secureCounter",
            style: TextStyle(
              fontSize: 48, 
              fontWeight: FontWeight.bold, 
              fontFamily: 'Courier',
              color: _isRunning ? Colors.amberAccent : Colors.greenAccent
            ),
          ),
          const SizedBox(height: 10),
          Row(
           // main Surrey: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_isRunning ? Icons.lock_open : Icons.lock, size: 14, color: _isRunning ? Colors.amber : Colors.greenAccent),
              const SizedBox(width: 6),
              Text(
                _isRunning ? "CONCURRENT PIPELINE ACTIVE" : "ARCHITECTURE SECURE - NO LOCKS NEEDED",
                style: TextStyle(fontSize: 11, color: _isRunning ? Colors.amber : Colors.greenAccent, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}