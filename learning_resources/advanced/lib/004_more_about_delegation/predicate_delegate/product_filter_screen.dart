import 'package:flutter/material.dart';
import 'predicate_logic.dart';

class ProductFilterScreen extends StatefulWidget {
  const ProductFilterScreen({super.key});

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  final ProductFilter _filterEngine = ProductFilter();

  // مصفوفة البيانات الأصلية المستهدفة بالبحث
  final List<Product> _allProducts = [
    Product(name: "آيفون 15 برومكس", price: 1200, isAvailable: true),
    Product(name: "سماعة بلوتوث اقتصادية", price: 45, isAvailable: true),
    Product(name: "شاحن سريع (غير متوفر)", price: 25, isAvailable: false),
    Product(name: "ساعة ذكية متطورة", price: 300, isAvailable: true),
    Product(name: "حافظة هاتف (غير متوفرة)", price: 15, isAvailable: false),
  ];

  List<Product> _displayedProducts = [];
  String _currentFilterName = "كل المنتجات";

  @override
  void initState() {
    super.initState();
    _displayedProducts = _allProducts; // البداية بعرض الكل
  }

  // دالة تستقبل الـ Predicate وتنفذ الفلترة ديناميكياً
  void _applyFilter(String filterName, ProductPredicate predicate) {
    setState(() {
      _currentFilterName = filterName;
      _displayedProducts = _filterEngine.filter(_allProducts, predicate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فلتر المنتجات الذكي (Predicate)'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('اختر قاعدة الفلترة (لتمرير الـ Predicate المناسب):', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _applyFilter("كل المنتجات", (p) => true), // يرجع true دائماً لتمرير الكل
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text('الكل', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: ElevatedButton(
                    // نمرر Predicate يفحص التوفر فقط
                    onPressed: () => _applyFilter("المتوفر فقط 🟢", (p) => p.isAvailable), 
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
                    child: const Text('المتوفر', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: ElevatedButton(
                    // نمرر Predicate يفحص السعر (أقل من 100 دولار)
                    onPressed: () => _applyFilter("المنتجات الاقتصادية (<${100}) 💰", (p) => p.price < 100),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800),
                    child: const Text('الاقتصادي', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('الفلتر النشط حالياً: $_currentFilterName', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
            const SizedBox(height: 10),
            Expanded(
              child: _displayedProducts.isEmpty
                  ? const Center(child: Text('لا توجد منتجات تطابق هذا الشرط!'))
                  : ListView.builder(
                      itemCount: _displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = _displayedProducts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: Icon(
                              product.isAvailable ? Icons.check_circle : Icons.cancel,
                              color: product.isAvailable ? Colors.green : Colors.red,
                            ),
                            title: Text(product.name),
                            trailing: Text('\$${product.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}