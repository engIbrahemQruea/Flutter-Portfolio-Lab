import 'dart:async';

/// هذا الكلاس يوازي كلاس الـ [DisposableResource] في كود المدرب.
/// وبما أن دارت لا تملك واجهة IDisposable، نحن نصنع دالة عرفية اسمها `dispose`.
class CustomStreamResource {
  // مجرى بث بيانات يحاكي اتصال شبكة نشط
  final StreamController<int> _liveDataController =
      StreamController<int>.broadcast();
  int _counter = 0;
  Timer? _timer;

  CustomStreamResource() {
    // محاكاة وصول بيانات كل ثانية من السيرفر
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      _counter++;
      if (!_liveDataController.isClosed) {
        _liveDataController.add(_counter);
      }
    });
  }

  Stream<int> get liveStream => _liveDataController.stream;

  /// 🎯 هذه الدالة تقابل تماماً دالة Dispose() في الـ IDisposable في سي شارب.
  /// يتم استدعاؤها لتنظيف الموارد غير المدارة والتايمر وإغلاق السوكيت.
  void dispose() {
    _timer?.cancel();
    _liveDataController.close();
    print("🟢 تم إغلاق الموارد بنجاح ومنع تسريب البيانات (No Leaks)!");
  }
}
