import 'dart:core';

class FlutterStringBuilderDemo {
  static void executeOptimizationExample() {
    print("⚡ [محرك Flutter للذاكرة]: بدء معالجة النصوص الديناميكية...");

    // 1️⃣ محاكاة الـ Capacity Management
    // في Dart، الـ StringBuffer يحجز مساحته ديناميكياً بكفاءة عالية جداً على مستوى الـ C++ Core
    final StringBuffer sb = StringBuffer();

    // 2️⃣ Efficient Concatenation (محاكاة دالة Append في سي شارب)
    sb.write("Falcon ERP System");
    sb.write(" - Version 2026");
    sb.writeAll([
      "\n",
      "Developer:",
      " Mohamed Abu-Hadhoud",
    ]); // إضافة مصفوفة دفعة واحدة

    print("\n--- الكود بعد الإضافة التدريجية المستقرة ---");
    print(sb.toString());

    // 3️⃣ محاكاة دوال التعديل المتقدمة (Insert, Remove, Replace)
    // نصوص Dart العادية تمتلك دوال قوية، ولكن عند دمجها مع StringBuffer نقوم بالتلاعب الذكي:
    String currentText = sb.toString();

    // أ: دالة الاستبدال (Replace)
    currentText = currentText.replaceAll(
      "Version 2026",
      "Enterprise Edition [Stable]",
    );

    // ب: دالة الحذف (Remove)
    // لنفترض أننا نريد حذف اسم المطور من النص لأغراض أمنية
    currentText = currentText.replaceFirst(
      "Developer: Mohamed Abu-Hadhoud",
      "",
    );

    // ج: دالة الإدخال (Insert)
    // إدخال نص في موقع محدد (مثلاً في بداية السطر)
    final int insertIndex = currentText.indexOf("Falcon");
    if (insertIndex != -1) {
      currentText =
          "${currentText.substring(0, insertIndex)}[CONFIDENTIAL] ${currentText.substring(insertIndex)}";
    }

    // 4️⃣ إعادة حقن النص المصفى داخل بافر نظيف لإنتاج المخرجات النهائية دون استهلاك الـ RAM
    final StringBuffer finalBuffer = StringBuffer(currentText);

    print("--- المخرجات النهائية المصفاة هندسياً من الذاكرة ---");
    print(finalBuffer.toString());

    // طباعة الإحصائيات (Length)
    print("\n📊 إجمالي عدد الحروف في البافر النظيف: ${finalBuffer.length}");
  }
}

void runPerformanceBenchmark() {
  const int iterations = 50000; // دمج 50 ألف مرة

  // 🔴 الاختبار الأول: استخدام معامل الجمع التقليدي (+) السيئ للذاكرة
  final stopwatch1 = Stopwatch()..start();
  String regularString = "";
  for (int i = 0; i < iterations; i++) {
    regularString += "A"; // في كل لفة يتم تدمير نص وإنشاء نص جديد بالكامل!
  }
  stopwatch1.stop();
  print(
    "🔴 الوقت المستغرق باستخدام المعامل التقليدي (+): ${stopwatch1.elapsedMilliseconds} ملي ثانية.",
  );

  // 🟢 الاختبار الثاني: استخدام الـ StringBuffer المحترف والمطور
  final stopwatch2 = Stopwatch()..start();
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < iterations; i++) {
    buffer.write("A"); // التعديل يتم في نفس الموقع بالذاكرة RAM
  }
  final String result = buffer.toString();
  stopwatch2.stop();
  print(
    "🟢 الوقت المستغرق باستخدام الـ StringBuffer الذكي: ${stopwatch2.elapsedMilliseconds} ملي ثانية.",
  );
}

void main() {
  // تشغيل مثال الدوال
  FlutterStringBuilderDemo.executeOptimizationExample();

  print("\n--------------------------------------------------");
  // تشغيل اختبار الأداء الحقيقي لإثبات صحة تدوينة المدرب
  runPerformanceBenchmark();
}
