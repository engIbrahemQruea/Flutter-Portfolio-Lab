// تمثيل كائن المنتج
class Product {
  final String name;
  final double price;
  final bool isAvailable;

  Product({required this.name, required this.price, required this.isAvailable});
}

// تعريف الـ Typedef ليعبر عن الـ Predicate في سي شارب (يستقبل منتج ويرجع bool)
typedef ProductPredicate = bool Function(Product product);

class ProductFilter {
  // دالة الفلترة تستقبل القائمة الكاملة، وتستقبل الـ Predicate الشرطي
  List<Product> filter(List<Product> originalList, ProductPredicate condition) {
    List<Product> filteredResult = [];
    for (var product in originalList) {
      // استدعاء الـ Predicate لفحص المنتج: إذا طابق الشرط (true) يتم إضافته
      if (condition(product)) {
        filteredResult.add(product);
      }
    }
    return filteredResult;
  }
}
