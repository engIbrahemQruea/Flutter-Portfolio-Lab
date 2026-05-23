import 'package:flutter/material.dart';

import 'currency_logic.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final CurrencyProcessor _processor = CurrencyProcessor();
  final TextEditingController _amountController = TextEditingController(
    text: "100",
  );

  String _convertedResult = "0.00";
  String _selectedTarget = "اضغط على عملة للتحويل";

  void _calculate(String currencyName, CurrencyFunc targetFunc) {
    double inputAmount = double.tryParse(_amountController.text) ?? 0.0;

    // نمرر الرقم والدالة (الـ Func) المحددة مباشرة للـ Processor
    double finalResult = _processor.convert(inputAmount, targetFunc);

    setState(() {
      _selectedTarget = currencyName;
      _convertedResult = finalResult.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محول العملات التفاعلي (Func Delegate)'),
        backgroundColor: Colors.amber.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'المبلغ بالدولار الأمريكي (USD) 💵:',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'اختر عملة الوجهة (لتمرير الـ Func المناسب):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    // نمرر دالة التحويل للسعودي كـ Func Parameter
                    onPressed: () =>
                        _calculate("ريال سعودي (SAR)", ExchangeRates.toSAR),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      '🇸🇦 SAR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    // نمرر دالة التحويل للإماراتي كـ Func Parameter
                    onPressed: () =>
                        _calculate("درهم إماراتي (AED)", ExchangeRates.toAED),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                    ),
                    child: const Text(
                      '🇦🇪 AED',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    // نمرر دالة التحويل لليورو كـ Func Parameter
                    onPressed: () =>
                        _calculate("يورو (EUR)", ExchangeRates.toEUR),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                    ),
                    child: const Text(
                      '🇪🇺 EUR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),

            // صندوق عرض النتيجة المحسوبة عبر الـ Func
            Card(
              color: Colors.amber.shade50,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      _selectedTarget,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.amber.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _convertedResult,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
