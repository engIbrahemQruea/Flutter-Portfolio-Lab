class TraceExample {
  // 🎯 استدعاء الرمز المخصص من بيئة التجميع (يوازي #define TRACE_ENABLED)
  // استخدمنا const لكي يعرف المترجم قيمتها وقت الـ Compile-time
  static const bool isTraceEnabled = bool.fromEnvironment(
    'TRACE_ENABLED',
    defaultValue: false,
  );

  // 🛡️ دالة التتبع المشروطة
  static void logTrace(String message) {
    // إذا كانت isTraceEnabled تساوي false، محرك فلاتر سيقوم بمسح محتوى
    // هذه الدالة بالكامل عند بناء نسخة الـ Release (Tree Shaking)
    if (isTraceEnabled) {
      print("[TRACE] $message");
    }
  }
}

void main() {
  print("بدأ تشغيل البرنامج...");

  // استدعاء الدالة المشروطة
  TraceExample.logTrace(
    "هذه الرسالة ستظهر فقط إذا تم تفعيل رمز TRACE_ENABLED وقت التجميع.",
  );

  print("باقي أجزاء البرنامج تعمل بشكل طبيعي.");
}
