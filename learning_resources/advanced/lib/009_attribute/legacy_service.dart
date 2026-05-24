class OldDatabaseService {
  // 🎯 استخدام @deprecated تماماً مثل [Obsolete] في C#
  // ستظهر خطوط صفراء تحذيرية للمطورين الذين يحاولون استدعاء هذه الدالة
  @deprecated
  void saveDataToLocalFile(String data) {
    print("تم الحفظ بالطريقة القديمة البطيئة: $data");
  }

  void saveDataToSecureStorage(String data) {
    print("🟢 تم الحفظ بالطريقة الحديثة المشفرة فائقة السرعة!");
  }
}
