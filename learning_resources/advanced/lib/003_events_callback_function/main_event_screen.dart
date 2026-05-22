import 'package:advanced/003_events_callback_function/custom_simple_calc.dart';
import 'package:advanced/003_events_callback_function/custom_temperature_changed.dart';
import 'package:advanced/003_events_callback_function/news_publisher_example/news_screen.dart';
import 'package:advanced/003_events_callback_function/news_publisher_example_tow/news_console_screen.dart';
import 'package:advanced/003_events_callback_function/temp_example_callback/thermostat_screen.dart';
import 'package:advanced/003_events_callback_function/temp_monitor_screen.dart';
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
          CustomTemperatureChanged(
            onTemperatureChanged: (args) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('${args.diffTemp}')));
            },
          ),
          CustomTemperatureChanged(
            onTemperatureChanged: (args) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('${args.diffTemp}')));
            },
          ),

          ElevatedButton.icon(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TemperatureMonitorScreen(),
                ),
              );
            },
            label: Text('Senstor Screen'),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThermostatScreen()),
              );
            },
            label: Text('Thermostat Screen'),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsAppScreen()),
              );
            },
            label: Text('News App Screen'),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsConsoleScreen()),
              );
            },
            label: Text('News Console Screen Using StreamController'),
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
