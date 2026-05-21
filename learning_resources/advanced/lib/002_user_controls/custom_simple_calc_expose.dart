import 'package:flutter/material.dart';

class SimpleCalcComponent extends StatefulWidget {
  const SimpleCalcComponent({super.key});

  @override
  State<SimpleCalcComponent> createState() => SimpleCalcComponentState();
}

class SimpleCalcComponentState extends State<SimpleCalcComponent> {
  // التحكم في حقول الإدخال داخلياً
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();

  // Private Field لتخزين النتيجة داخلياً
  double _result = 0.0;

  // الخصائص المكشوفة للخارج (Exposed Property - Getter Only)
  // هذا هو المكافئ الحرفي لكود المدرب في الـ get
  double get result => _result;

  void _calculate() {
    // ميزة Dart الحديثة:TryParse لمنع انهيار التطبيق إذا كانت الحقول فارغة أو تحتوي نصوصاً
    final num1 = double.tryParse(_number1Controller.text) ?? 0.0;
    final num2 = double.tryParse(_number2Controller.text) ?? 0.0;

    setState(() {
      _result = num1 + num2; // تحديث الواجهة والنتيجة داخلياً
    });
  }

  @override
  void dispose() {
    // تنظيف الموارد لحماية الذاكرة (Memory Management)
    _number1Controller.dispose();
    _number2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // تصميم واجهة الـ User Control المصغرة
    return Card(
      elevation: 4,
      // padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _number1Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Number 1'),
          ),
          TextField(
            controller: _number2Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Number 2'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calculate, child: const Text('Calculate')),
          const SizedBox(height: 16),
          // عرض النتيجة داخل المكون
          Text(
            'Result: $_result',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
