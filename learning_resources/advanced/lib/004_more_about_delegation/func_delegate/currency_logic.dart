// تعريف الـ Typedef ليعبر عن شكل الـ Func في سي شارب
// يستقبل رقم (المبلغ) ويرجع رقم (القيمة المرجعة)
typedef CurrencyFunc = double Function(double amount);

class CurrencyProcessor {
  // دالة المعالجة تستقبل المبلغ، والمعادلة المفوضة (الـ Func)
  double convert(double amount, CurrencyFunc conversionAlgorithm) {
    if (amount <= 0) return 0.0;
    // استدعاء الـ Func وحساب النتيجة
    return conversionAlgorithm(amount);
  }
}

// المعادلات الجاهزة التي تمثل الـ Funcs خلف الكواليس
class ExchangeRates {
  // تحويل من دولار إلى ريال سعودي (مثلاً الضرب في 3.75)
  static double toSAR(double usd) => usd * 3.75;

  // تحويل من دولار إلى درهم إماراتي (الضرب في 3.67)
  static double toAED(double usd) => usd * 3.67;

  // تحويل من دولار إلى يورو (محاكاة الضرب في 0.92)
  static double toEUR(double usd) => usd * 0.92;
}
