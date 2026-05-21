// // 111111
// // simple_calc_state.dart
// // استخدام الـ sealed class (ميزة Dart 3 الحديثة) لتعريف الحالات بشكل آمن ومغلق
// sealed class SimpleCalcState {
//   final double result;
//   const SimpleCalcState(this.result);
// }

// class SimpleCalcInitial extends SimpleCalcState {
//   const SimpleCalcInitial() : super(0.0);
// }

// class SimpleCalcUpdated extends SimpleCalcState {
//   const SimpleCalcUpdated(super.result);
// }

// // simple_calc_cubit.dart
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SimpleCalcCubit extends Cubit<SimpleCalcState> {
//   SimpleCalcCubit() : super(const SimpleCalcInitial());

//   // المنطق الحسابي لكود المدرب تم نقله إلى الـ Cubit
//   void calculate(String num1Str, String num2Str) {
//     final num1 = double.tryParse(num1Str) ?? 0.0;
//     final num2 = double.tryParse(num2Str) ?? 0.0;
    
//     final finalResult = num1 + num2;
//     emit(SimpleCalcUpdated(finalResult));
//   }
// }

// // 222222222222222222222222222
// // simple_calc_component.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SimpleCalcComponent extends StatelessWidget {
//   // حقول الإدخال يتم التحكم بها محلياً في شاشة التصميم
//   final TextEditingController _number1Controller = TextEditingController();
//   final TextEditingController _number2Controller = TextEditingController();

//   SimpleCalcComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _number1Controller,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Number 1'),
//             ),
//             TextField(
//               controller: _number2Controller,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Number 2'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // إرسال البيانات للـ Cubit لتقوم بالحساب (مثل btnCalculate_Click)
//                 context.read<SimpleCalcCubit>().calculate(
//                   _number1Controller.text,
//                   _number2Controller.text,
//                 );
//               },
//               child: const Text('Calculate'),
//             ),
//             const SizedBox(height: 16),
            
//             // الاستماع للـ Cubit لعرض النتيجة داخلياً (الـ Getter المحدث تلقائياً)
//             BlocBuilder<SimpleCalcCubit, SimpleCalcState>(
//               builder: (context, state) {
//                 return Text(
//                   'Result: ${state.result}',
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // 3333333333333
// // home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // 1. حقن الـ Cubit في أعلى الشاشة ليكون متاحاً للحاسبة ولأي عنصر خارجي
//     return BlocProvider(
//       create: (context) => SimpleCalcCubit(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Form 1 - Cubit Architecture')),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // 2. استدعاء الـ User Control (بدون أي كيز أو تعقيد)
//               SimpleCalcComponent(),
              
//               const SizedBox(height: 40),
              
//               // 3. زر خارجي تماماً في الشاشة الرئيسية يقرأ النتيجة (الـ Property العاكسة)
//               // نستخدم BlocBuilder هنا للاستماع لأي تغيير في النتيجة فوراً
//               BlocBuilder<SimpleCalcCubit, SimpleCalcState>(
//                 builder: (context, state) {
//                   return ElevatedButton.icon(
//                     icon: const Icon(Icons.ads_click),
//                     label: Text('النتيجة الحالية في الخارجية هي: ${state.result}'),
//                     onPressed: () {
//                       // يمكنك استخدام state.result مباشرة هنا في أي منطق خارجي
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('تم تأكيد النتيجة: ${state.result}')),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }