import 'dart:core';

class Program {
  static void main() {
    // 200,000 تكرار تماماً كما حدد المدرب محمد أبو هدهود
    const int iterations = 200000;

    print("🚀 بدء تشغيل الـ Benchmark المتقدم داخل محرك Dart...\n");

    // 🔴 الجزء الأول: دمج النصوص باستخدام معامل الجمع التقليدي (+)
    final stopwatch1 = Stopwatch()..start();
    concatenateStrings(iterations);
    stopwatch1.stop();
    print(
      "🔴 String concatenation using + took: ${stopwatch1.elapsedMilliseconds} ms",
    );

    // 🟢 الجزء الثاني: دمج النصوص باستخدام StringBuffer المحترف
    final stopwatch2 = Stopwatch()..start();
    concatenateStringBuilder(iterations);
    stopwatch2.stop();
    print(
      "🟢 String concatenation using StringBuffer took: ${stopwatch2.elapsedMilliseconds} ms",
    );
  }

  /// دالة الدمج التقليدية المجهدة للمعالج والذاكرة
  static void concatenateStrings(int iterations) {
    String result = "";
    for (int i = 0; i < iterations; i++) {
      result += "a"; // توليد كائنات ميتة وضغط على الـ Garbage Collector
    }
    // استخدام وهمي للمتغير لتجنب تحسينات المترجم الذكية (Dead Code Elimination)
    if (result.isEmpty) print("Empty");
  }

  /// دالة الدمج الذكية الصديقة للـ RAM والأداء
  static void concatenateStringBuilder(int iterations) {
    // StringBuffer هو التوأم المعماري لـ StringBuilder في C#
    final StringBuffer sb = StringBuffer();
    for (int i = 0; i < iterations; i++) {
      sb.write("a"); // تعديل البافر داخلياً بمستوى الـ C++ Core دون نسخ متكرر
    }
    String result = sb.toString(); // تحويل التجميع النهائي لمرة واحدة فقط
    if (result.isEmpty) print("Empty");
  }
}

void main() {
  // تشغيل الاختبار المعماري
  Program.main();
}
