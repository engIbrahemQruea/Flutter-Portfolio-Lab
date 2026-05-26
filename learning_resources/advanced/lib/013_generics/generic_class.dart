// 🏗️ بناء الكلاس العام بنفس الفلسفة الهندسية
class GenericBox<T> {
  // جعل الحقل نهائي (Immutable) تماشياً مع معايير فلاتر
  final T _content;

  // مشيّد مختصر يقوم بالتعيين التلقائي فوراً
  GenericBox(this._content);

  // دالة الاسترجاع باستخدام سهم الاختصار (Arrow Syntax)
  T getContent() => _content;
}

void main() {
  // 1. استخدام الكلاس مع الأرقام الصحيحة (int)
  final intBox = GenericBox<int>(42);
  print("Content of intBox: ${intBox.getContent()}"); // Outputs: 42

  // 2. استخدام نفس الكلاس مع النصوص (String)
  final stringBox = GenericBox<String>("Hello, World!");
  print(
    "Content of stringBox: ${stringBox.getContent()}",
  ); // Outputs: Hello, World!

  // 🛡️ حماية الأنواع: السطر التالي سيسبب خطأ يمنعه المترجم فوراً:
  // intBox._content = "Test";
}
