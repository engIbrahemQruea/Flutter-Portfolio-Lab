import 'package:flutter/material.dart';

class SyncLabScreen extends StatefulWidget {
  const SyncLabScreen({super.key});

  @override
  State<SyncLabScreen> createState() => _SyncLabScreenState();
}

class _SyncLabScreenState extends State<SyncLabScreen> {
  int _bankBalance = 100;
  bool _isProcessing = false; // 🛡️ الحارس المعماري (المعادل لـ Lock)
  final List<String> _transactionHistory = [];

  void _log(String msg) {
    setState(() => _transactionHistory.insert(0, msg));
  }

  /// 🛠️ الدالة المحمية بالمزامنة المنطقية (Mutual Exclusion Pipeline)
  Future<void> _secureWithdraw(int amount) async {
    // 1. التحقق من القفل: إذا كانت الدالة مشغولة حالياً، ارفض الطلب فوراً (استبعاد متبادل)
    if (_isProcessing) {
      _log(
        "⚠️ [Blocked]: محاولة ضغط مرفوضة! دالة السحب قيد التنفيذ حالياً تحت حماية القفل.",
      );
      return;
    }

    // 2. تفعيل القفل (Lock Acquisition)
    setState(() {
      _isProcessing = true;
    });

    _log(
      "🔒 [Lock Acquired]: تم قفل الدالة. بدء معالجة طلب السحب بقيمة $amount \$.",
    );

    try {
      // محاكاة تأخير معالجة الشبكة أو السيرفر (ثانيتين)
      await Future.delayed(const Duration(seconds: 5));

      if (_bankBalance >= amount) {
        setState(() {
          _bankBalance -= amount;
        });
        _log("💰 [Success]: تم الخصم بنجاح! الرصيد الحالي: $_bankBalance \$");
      } else {
        _log(
          "❌ [Failed]: فشل السحب.. رصيد غير كافٍ. الرصيد الحالي: $_bankBalance \$",
        );
      }
    } finally {
      // 3. 🔴 خطوة إلزامية هندسياً: فتح القفل دائماً في الـ finally لضمان عدم حدوث Deadlock
      setState(() {
        _isProcessing = false;
      });
      _log(
        "🔓 [Lock Released]: تم فتح القفل ودالة السحب جاهزة لاستقبال طلب جديد.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🔒 Mutual Exclusion Simulator"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 114, 137, 183),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 25),

            // زر السحب البنكي المعرض للضغط المتكرر العشوائي
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isProcessing
                    ? Colors.amber.shade800
                    : Colors.indigo.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => _secureWithdraw(50), // سحب 50 دولار في كل ضغطة
              icon: Icon(_isProcessing ? Icons.lock : Icons.lock_open),
              label: Text(
                _isProcessing
                    ? "PROCESSING TRANSACTION..."
                    : "Withdraw 50 \$ (Try Double Tap)",
              ),
            ),
            const SizedBox(height: 25),

            // 🖥️ لوحة تتبع حركة الخيوط والمزامنة (Transaction Trace)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF101622),
                  borderRadius: BorderRadius.circular(12),
                  //  border: BorderSide(color: Colors.indigo.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.history_toggle_off,
                          color: Colors.indigoAccent,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Logical Synchronization Logs",
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
                        itemCount: _transactionHistory.length,
                        itemBuilder: (context, index) {
                          String log = _transactionHistory[index];
                          Color txtColor = Colors.white;
                          if (log.contains("Blocked"))
                            txtColor = Colors.redAccent;
                          if (log.contains("Success"))
                            txtColor = Colors.greenAccent;
                          if (log.contains("Acquired"))
                            txtColor = Colors.amberAccent;
                          if (log.contains("Released"))
                            txtColor = Colors.cyanAccent;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              log,
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 12,
                                color: txtColor,
                                fontWeight: FontWeight.bold,
                                height: 1.4,
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

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF101622),
        borderRadius: BorderRadius.circular(12),
        // border: BorderSide(color: Colors.indigo.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          const Text(
            "BANK ACCOUNT BALANCE",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "\$${_bankBalance}",
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              fontFamily: 'Courier',
              color: Colors.indigoAccent,
            ),
          ),
        ],
      ),
    );
  }
}
