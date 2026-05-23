import 'package:advanced/005_lambda_expression/lambda_closure_logic.dart';
import 'package:flutter/material.dart';

class LambdaStoreScreen extends StatefulWidget {
  const LambdaStoreScreen({super.key});

  @override
  State<LambdaStoreScreen> createState() => _LambdaStoreScreenState();
}

class _LambdaStoreScreenState extends State<LambdaStoreScreen> {
  final CartManager _cart = CartManager();
  final double _productBasePrice = 200.0; // السعر الأصلي للمنتج

  double _finalPrice = 200.0;
  String _appliedRule = "لا يوجد خصم حالياً";

  // دالة توضح مفهوم الـ Closure واصطياد المتغيرات المحيطة
  void _applyDiscount(String ruleName, double discountPercent) {
    setState(() {
      _appliedRule = ruleName;

      // هنا نمرر Arrow Function (Lambda) مباشرة كمُعامل (Inline Definition)
      // لاحظ كيف التقطت الدالة المجهولة المتغير الخارجي (discountPercent) واستخدمته داخلياً (Closure)
      _finalPrice = _cart.calculateFinalPrice(
        _productBasePrice,
        (price) => price - (price * (discountPercent / 100)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قوة الـ Lambda & Closures'),
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'المنتج: حذاء رياضي فاخر',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'السعر الأصلي: \$$_productBasePrice',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'السعر بعد الخصم الـ Inline: \$$_finalPrice',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'القاعدة المنفذة: $_appliedRule',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'اضغط لتمرير دالة الخصم (Inline Lambda Definition):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => _applyDiscount(
                "خصم التصفيات الصيفية",
                15,
              ), // يمرر دالة تخصم 15%
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text(
                'تطبيق خصم 15% (عبر الـ Lambda)',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () => _applyDiscount(
                "خصم الجمعة البيضاء الفائق",
                40,
              ), // يمرر دالة تخصم 40%
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade700,
              ),
              child: const Text(
                'تطبيق خصم 40% (عبر الـ Lambda)',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),

            OutlinedButton(
              onPressed: () {
                setState(() {
                  _finalPrice = _productBasePrice;
                  _appliedRule = "إعادة تعيين";
                });
              },
              child: const Text('إلغاء الخصومات'),
            ),
          ],
        ),
      ),
    );
  }
}
