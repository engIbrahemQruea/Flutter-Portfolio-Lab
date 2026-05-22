import 'package:advanced/003_events_callback_function/new_order_event_example/order_engine_logic.dart';
import 'package:flutter/material.dart';

class OrderDashboardScreen extends StatefulWidget {
  const OrderDashboardScreen({super.key});

  @override
  State<OrderDashboardScreen> createState() => _OrderDashboardScreenState();
}

class _OrderDashboardScreenState extends State<OrderDashboardScreen> {
  // 🚀 إنشاء المحركات والأنظمة الأساسية
  final OrderManager _orderManager = OrderManager();
  late OrderSubscriber _paymentSystem;
  late OrderSubscriber _shippingSystem;

  // حالات الاشتراك للتحكم بها من الواجهة عبر الـ Switches
  bool _isPaymentSubscribed = true;
  bool _isShippingSubscribed = true;

  final List<String> _dashboardLogs = [];
  final TextEditingController _nameController = TextEditingController(
    text: "أحمد عبد الله",
  );
  final TextEditingController _amountController = TextEditingController(
    text: "150.0",
  );
  int _orderCounter = 1001; // عداد تلقائي لأرقام الطلبات

  @override
  void initState() {
    super.initState();

    // إعداد نظام الدفع بتمرير دالة المعالجة كـ Parameter داخل المنشئ
    _paymentSystem = OrderSubscriber(
      "نظام الفواتير والدفع",
      onHandleEvent: (OrderEventArgs e) {
        return "💳 [نظام الدفع]: جاري سحب مبلغ \$${e.totalAmount} لحساب العميل (${e.customerName}).";
      },
    );

    // إعداد نظام الشحن بنفس الأسلوب الصحيح
    _shippingSystem = OrderSubscriber(
      "نظام المخازن والشحن",
      onHandleEvent: (OrderEventArgs e) {
        return "📦 [نظام الشحن]: تم حجز المنتجات للطلب رقم #${e.orderId} وتحضير الشاحنة.";
      },
    );

    // تفعيل الاشتراكات الابتدائية
    _togglePaymentSubscription(true);
    _toggleShippingSubscription(true);
  }

  void _logToDashboard(String message) {
    setState(() {
      _dashboardLogs.add(message);
    });
  }

  // دالة إدارة إشتراك نظام الدفع (Subscribe / Unsubscribe)
  void _togglePaymentSubscription(bool subscribe) {
    if (subscribe) {
      _paymentSystem.subscribe(_orderManager, _logToDashboard);
    } else {
      _paymentSystem.unsubscribe();
      _logToDashboard("❌ [نظام الدفع]: قام بفصل السلك البرمجي (Unsubscribed).");
    }
  }

  // دالة إدارة إشتراك نظام الشحن (Subscribe / Unsubscribe)
  void _toggleShippingSubscription(bool subscribe) {
    if (subscribe) {
      _shippingSystem.subscribe(_orderManager, _logToDashboard);
    } else {
      _shippingSystem.unsubscribe();
      _logToDashboard("❌ [نظام الشحن]: قام بفصل السلك البرمجي (Unsubscribed).");
    }
  }

  void _executeOrderPlacement() {
    final String name = _nameController.text;
    final double? amount = double.tryParse(_amountController.text);

    if (name.isEmpty || amount == null) return;

    final String currentOrderId = _orderCounter.toString();
    _orderCounter++; // زيادة العداد للطلب القادم

    _logToDashboard(
      "\n🛒 [متجرنا الإيجابي]: تم الضغط على زر تأمين الطلب رقم #$currentOrderId...",
    );

    // البث الفعلي للحدث من الناشر (الـ Invoke الممتع!)
    _orderManager.placeNewOrder(currentOrderId, name, amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة معالجة الطلبات البرمجية'),
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. واجهة محاكاة إتمام الطلب من قبل العميل
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      '🛒 محاكاة هاتف العميل (إرسال طلب جديد)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'اسم العميل',
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration: const InputDecoration(
                              labelText: 'إجمالي الحساب (\$)',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _executeOrderPlacement,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('اضغط هنا لإتمام الطلب والتشغيل 🚀'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            // 2. أزرار التحكم بالاشتراكات (قواطع الأسلاك الحية)
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text(
                      'نظام الدفع',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _isPaymentSubscribed ? "متصل برمجياً" : "مفصول",
                      style: const TextStyle(fontSize: 10),
                    ),
                    value: _isPaymentSubscribed,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      setState(() {
                        _isPaymentSubscribed = val;
                      });
                      _togglePaymentSubscription(val);
                    },
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text(
                      'نظام الشحن',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _isShippingSubscribed ? "متصل برمجياً" : "مفصول",
                      style: const TextStyle(fontSize: 10),
                    ),
                    value: _isShippingSubscribed,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      setState(() {
                        _isShippingSubscribed = val;
                      });
                      _toggleShippingSubscription(val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // 3. شاشة الرصد والمراقبة التفاعلية للمخرجات
            const Row(
              children: [
                Icon(Icons.monitor_heart, color: Colors.indigo),
                SizedBox(width: 8),
                Text(
                  'نظام المراقبة والتحليل المركزي (Logs):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(12),
                child: _dashboardLogs.isEmpty
                    ? const Center(
                        child: Text(
                          'بانتظار العمليات البرمجية البثية...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _dashboardLogs.length,
                        itemBuilder: (context, index) {
                          String log = _dashboardLogs[index];
                          Color textColor = Colors.white;
                          if (log.contains('💳'))
                            textColor = Colors.amberAccent;
                          if (log.contains('📦'))
                            textColor = Colors.lightBlueAccent;
                          if (log.contains('❌')) textColor = Colors.redAccent;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              log,
                              style: TextStyle(
                                color: textColor,
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

  @override
  void dispose() {
    _orderManager.dispose(); // تنظيف الذاكرة بشكل نهائي
    super.dispose();
  }
}
