import 'dart:async';

// 1. حقيبة البيانات (OrderEventArgs)
class OrderEventArgs {
  final int orderID;
  final int orderTotalPrice;
  final String clientEmail;

  OrderEventArgs(this.orderID, this.orderTotalPrice, this.clientEmail);
}

// 2. كلاس الناشر (Order)
class Order {
  // الـ StreamController هو المسؤول عن بث الحدث لجميع الخدمات المشتركة
  final StreamController<OrderEventArgs> _onOrderCreatedController =
      StreamController<OrderEventArgs>.broadcast();

  // هذا هو الحدث (Event) الذي تستمع له الخدمات بالخارج
  Stream<OrderEventArgs> get onOrderCreated => _onOrderCreatedController.stream;

  void create(int orderID, int orderTotalPrice, String clientEmail) {
    // إشعار بدء العملية
    _onOrderCreatedController.add(
      OrderEventArgs(orderID, orderTotalPrice, clientEmail),
    );
  }

  void dispose() {
    _onOrderCreatedController.close();
  }
}

// 3. خدمة البريد الإلكتروني (EmailService)
class EmailService {
  final void Function(String) onLog; // الدالة الوسيطة للطباعة في الواجهة
  StreamSubscription<OrderEventArgs>? _subscription;

  EmailService(this.onLog);

  void subscribe(Order order) {
    _subscription = order.onOrderCreated.listen((e) {
      handleNewOrder(order, e);
    });
  }

  void unSubscribe(Order order) {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }

  void handleNewOrder(Object sender, OrderEventArgs e) {
    onLog(
      "----------Email Service--------\n"
      "Email Service Object Received a new order event\n"
      "Order ID: ${e.orderID}\n"
      "Order Price: ${e.orderTotalPrice}\n"
      "Email: ${e.clientEmail}\n\n"
      "Send an email\n"
      "--------------------------------\n",
    );
  }
}

// 4. خدمة الرسائل النصية (SMSService)
class SMSService {
  final void Function(String) onLog;
  StreamSubscription<OrderEventArgs>? _subscription;

  SMSService(this.onLog);

  void subscribe(Order order) {
    _subscription = order.onOrderCreated.listen((e) {
      handleNewOrder(order, e);
    });
  }

  void unSubscribe(Order order) {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }

  void handleNewOrder(Object sender, OrderEventArgs e) {
    onLog(
      "------------SMS Service--------\n"
      "SMS Service Object Received a new order event\n"
      "Order ID: ${e.orderID}\n"
      "Order Price: ${e.orderTotalPrice}\n"
      "Email: ${e.clientEmail}\n\n"
      "Send SMS\n"
      "--------------------------------\n",
    );
  }
}

// 5. خدمة الشحن (ShippingService)
class ShippingService {
  final void Function(String) onLog;
  StreamSubscription<OrderEventArgs>? _subscription;

  ShippingService(this.onLog);

  void subscribe(Order order) {
    _subscription = order.onOrderCreated.listen((e) {
      handleNewOrder(order, e);
    });
  }

  void unSubscribe(Order order) {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }

  void handleNewOrder(Object sender, OrderEventArgs e) {
    onLog(
      "---------Shipping Service-------\n"
      "Shipping Service Object Received a new order event\n"
      "Order ID: ${e.orderID}\n"
      "Order Price: ${e.orderTotalPrice}\n"
      "Email: ${e.clientEmail}\n\n"
      "Handel Shipping\n"
      "--------------------------------\n",
    );
  }
}
