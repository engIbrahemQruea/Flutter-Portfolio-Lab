class CartManager {
  // دالة تحسب السعر النهائي وتستقبل الـ Lambda (توازي Func<double, double>)
  // لتطبيق عملية الخصم المباشر (Inline Operation)
  double calculateFinalPrice(double price, double Function(double) discountStrategy) {
    return discountStrategy(price);
  }
}