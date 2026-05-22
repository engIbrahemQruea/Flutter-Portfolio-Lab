import 'dart:async';

// 1. حقيبة بيانات الطلب
class OrderEventArgs {
  final String orderId;
  final String customerName;
  final double totalAmount;

  OrderEventArgs(this.orderId, this.customerName, this.totalAmount);
}

// 2. الناشر المركزي (OrderManager)
class OrderManager {
  final StreamController<OrderEventArgs> _orderPlacedController =
      StreamController<OrderEventArgs>.broadcast();
  Stream<OrderEventArgs> get orderPlaced => _orderPlacedController.stream;

  void placeNewOrder(String orderId, String customerName, double totalAmount) {
    final args = OrderEventArgs(orderId, customerName, totalAmount);
    _onOrderPlaced(args);
  }

  void _onOrderPlaced(OrderEventArgs e) {
    _orderPlacedController.add(e);
  }

  void dispose() {
    _orderPlacedController.close();
  }
}

// 3. كلاس المشترك المحدث (يستقبل دالة المعالجة كـ Parameter)
class OrderSubscriber {
  final String systemName;
  // دالة مخصصة ترجع نصاً وتستقبل حقيبة البيانات
  final String Function(OrderEventArgs e) onHandleEvent;
  StreamSubscription<OrderEventArgs>? _subscription;

  // المنشئ يستقبل الدالة المخصصة لكل نظام الآن
  OrderSubscriber(this.systemName, {required this.onHandleEvent});

  void subscribe(OrderManager manager, void Function(String) onLog) {
    _subscription = manager.orderPlaced.listen((order) {
      // استدعاء الدالة الممررة وتوجيه النتيجة للواجهة
      String logMessage = onHandleEvent(order);
      onLog(logMessage);
    });
  }

  void unsubscribe() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }
}
