class Utility {
  // 🎯 دالة عامة تستقبل قيمتين وتعيد "سجل" (Record) يحتوي عليهما متبادلتين!
  static (T, T) swap<T>(T first, T second) {
    // نعيد القيمة الثانية أولاً، ثم الأولى
    return (second, first);
  }
}

void main() {
  // 1. التطبيق مع الأرقام (Integers)
  int a = 5, b = 10;
  print("Before swap: a = $a, b = $b");

  // 💥 تفكيك السجل (Destructuring) لإعادة التعيين بأسلوب دارت الحديث
  (a, b) = Utility.swap(a, b);
  print("After swap: a = $a, b = $b\n");

  // 2. التطبيق مع النصوص (Strings)
  String x = "Hello", y = "World";
  print("Before swap: x = $x, y = $y");

  // نفس الدالة العامة تعمل مع النصوص بأمان كامل واستنتاج تلقائي للنوع
  (x, y) = Utility.swap(x, y);
  print("After swap: x = $x, y = $y");
}
