import 'package:advanced/003_events_callback_function/custom_simple_calc.dart';
import 'package:flutter/material.dart';

class MainEventScreen extends StatelessWidget {
  const MainEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Screen Listening to Events')),
      body: Column(
        children: [
          Text('Hiiii'),

          // الاشتراك في الحدث واستقبال النتيجة فور انطلاقها من داخل الـ User Control
          CustomSimpleCalc(
            onCalculationComplete: (calculatedResult) {
              // هذا الكود يربطه الأب، ولكنه ينفذ بناءً على ضغطة الزر داخل الابن!
              print("تم استقبال الحدث في الشاشة الخارجية بنجاح!");

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('وصلنا حدث خارجي! النتيجة: $calculatedResult'),
                ),
              );
            },
          ),

          // Using Cubit
          // // في الشاشة الخارجية (الأب)، نستخدم BlocListener المخصص للاستماع للأحداث (Side Effects)
          // BlocListener<SimpleCalcCubit, SimpleCalcState>(
          //   // هذا الشرط يضمن أن الكود لا يعمل إلا إذا تغيرت النتيجة (مكافئ لإطلاق الحدث)
          //   listenWhen: (previous, current) => current is SimpleCalcUpdated,
          //   listener: (context, state) {
          //     // استقبال الحدث والتصرف بناءً عليه في الشاشة الخارجية
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text(
          //           'الـ Cubit أرسل حدثاً: النتيجة تحدثت إلى ${state.result}',
          //         ),
          //       ),
          //     );
          //   },
          //   child: SimpleCalcComponent(), // الـ User Control الخاص بنا
          // ),
        ],
      ),
    );
  }
}
