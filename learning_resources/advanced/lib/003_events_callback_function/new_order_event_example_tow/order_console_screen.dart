import 'package:advanced/003_events_callback_function/new_order_event_example_tow/order_engine_logic_tow.dart';
import 'package:flutter/material.dart';

class OrderConsoleScreen extends StatefulWidget {
  const OrderConsoleScreen({super.key});

  @override
  State<OrderConsoleScreen> createState() => _OrderConsoleScreenState();
}

class _OrderConsoleScreenState extends State<OrderConsoleScreen> {
  // مصفوفة لتخزين كل السطور المطبوعة وعرضها في الكونسول المرئي
  final List<String> _consoleOutputs = [];

  // دالة لتوجيه المخرجات للواجهة فوراً عبر الـ setState
  void _writeToUIConsole(String text) {
    setState(() {
      _consoleOutputs.add(text);
    });
  }

  // المحاكاة المطابقة لـ static void Main(string[] args) بكود المدرب
  void _runCoachSimulation() {
    setState(() {
      _consoleOutputs.clear(); // تنظيف الشاشة قبل البدء
    });

    _writeToUIConsole(
      "New Order created; now will notify everyone by raising the event.\n",
    );

    // 1. إنشاء كائن الناشر (Order)
    var order = Order();

    // 2. إنشاء كائنات الخدمات وتمرير دالة الطباعة لها
    EmailService emailService = EmailService(_writeToUIConsole);
    SMSService smsService = SMSService(_writeToUIConsole);
    ShippingService shippingService = ShippingService(_writeToUIConsole);

    // 3. تنفيذ سيناريو الاشتراكات الخاص بالمدرب
    emailService.subscribe(order);
    smsService.subscribe(order);
    shippingService.subscribe(order);

    // إلغاء اشتراك خدمة الشحن قبل توليد الطلب (كما فعل المدرب تماماً!)
    shippingService.unSubscribe(order);

    // 4. إطلاق الحدث لإنشاء الطلب رقم 10 بمبلغ 540
    order.create(10, 540, "Ahmed@gmail.com");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محاكي أحداث الطلبات (كود المدرب)'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _runCoachSimulation,
              icon: const Icon(Icons.play_arrow),
              label: const Text('تشغيل السيناريو بالكامل 🚀'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Row(
              children: [
                Icon(Icons.terminal, color: Colors.blueGrey),
                SizedBox(width: 8),
                Text(
                  'مخرجات الكونسول داخل التطبيق:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // شاشة الكونسول السوداء الافتراضية
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade50, width: 2),
                ),
                padding: const EdgeInsets.all(14.0),
                child: _consoleOutputs.isEmpty
                    ? const Center(
                        child: Text(
                          'بانتظار تشغيل السيناريو...',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'monospace',
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _consoleOutputs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              _consoleOutputs[index],
                              style: const TextStyle(
                                color: Colors.lightGreenAccent,
                                fontFamily: 'monospace',
                                fontSize: 13,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
