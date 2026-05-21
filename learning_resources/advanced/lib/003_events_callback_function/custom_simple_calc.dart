// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomSimpleCalc extends StatelessWidget {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();

  final void Function(double result)? onCalculationComplete;

  CustomSimpleCalc({
    Key? key,
    this.onCalculationComplete, // استقبال المشترك من الخارج عبر الـ Constructor
  });

  void _calculate() {
    final num1 = double.tryParse(_number1Controller.text) ?? 0.0;
    final num2 = double.tryParse(_number2Controller.text) ?? 0.0;
    final result = num1 + num2;

    // 2. إطلاق الحدث (مكافئ الـ Event Invocation)
    // نتحقق أولاً إذا كان الطرف الخارجي قد اشترك في الحدث (ليست null)
    if (onCalculationComplete != null) {
      onCalculationComplete!(
        result,
      ); // إرسال النتيجة فوراً عبر قناة الـ Callback
    }
  }

  /// 2. الطريقة المتقدمة: تمرير كائن معقد (Custom Event Arguments)

  //   // 1. كلاس يمثل حقيبة البيانات المشابه لـ EventArgs في #C
  // class CalculationEventArgs {
  //   final double result;
  //   final String operationType;
  //   final DateTime timestamp;

  //   CalculationEventArgs({
  //     required this.result,
  //     required this.operationType,
  //     required this.timestamp,
  //   });
  // }

  // // 2. شكل تعريفه داخل الـ User Control
  // final void Function(CalculationEventArgs args)? onCalculationComplete;

  // // 3. طريقة إطلاقه من داخل الـ User Control
  // void _calculate() {
  //   // ... حساب النتيجة ...
  //   if (onCalculationComplete != null) {
  //     onCalculationComplete!(
  //       CalculationEventArgs(
  //         result: 150.0,
  //         operationType: 'Addition',
  //         timestamp: DateTime.now(),
  //       ),
  //     );
  //   }
  // }

  ///3. كيف نمرر الـ Parameter عبر الـ Cubit؟

  //   // الاستماع للحدث واستخراج الـ Parameter في الشاشة الخارجية عبر الـ Cubit
  // BlocListener<SimpleCalcCubit, SimpleCalcState>(
  //   listener: (context, state) {
  //     if (state is SimpleCalcUpdated) {
  //       // قراءة الـ Parameter المرفق بالحالة مباشرة
  //       final double resultFromEvent = state.result;

  //       print("تم التقاط المتغير من الـ Cubit State: $resultFromEvent");
  //     }
  //   },
  //   child: SimpleCalcComponent(),
  // )

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _number1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Num 1'),
            ),
            TextField(
              controller: _number2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Num 2'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),

            Text('Result:$onCalculationComplete'),
          ],
        ),
      ),
    );
  }
}
