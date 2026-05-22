import 'package:advanced/003_events_callback_function/custom_temperature_changed.dart';
import 'package:flutter/material.dart';

class TemperatureMonitorScreen extends StatefulWidget {
  const TemperatureMonitorScreen({super.key});

  @override
  State<TemperatureMonitorScreen> createState() =>
      _TemperatureMonitorScreenState();
}

class _TemperatureMonitorScreenState extends State<TemperatureMonitorScreen> {
  String _statusMessage = "النظام مستقر";
  Color _displayColor = Colors.green;
  double _lastDiff = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نظام مراقبة الحرارة - Events')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شاشة العرض الرقمية التابعة للـ Form الرئيسية
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _displayColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _displayColor, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    _statusMessage,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _displayColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'مقدار التغير الحالي: ${_lastDiff.toStringAsFixed(1)} °C',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // حقن الـ Component الخاص بالمستشعر والاشتراك في الحدث بتاعه
            TemperatureSensorComponent(
              onTemperatureChanged: (e) {
                // معالجة البيانات المستلمة من كائن الـ EventArgs (e)
                double diff = e.newTemp - e.oldTemp;

                setState(() {
                  _lastDiff = diff.abs();

                  if (e.newTemp > 35.0) {
                    _statusMessage =
                        "⚠️ خطر: الحرارة مرتفعة جداً! تشغيل التكييف الأقصى";
                    _displayColor = Colors.red;
                  } else if (e.newTemp < 15.0) {
                    _statusMessage = "❄️ تنبيه: الجو بارد؛ تشغيل نظام التدفئة";
                    _displayColor = Colors.blue;
                  } else {
                    _statusMessage = "✅ النظام مستقر: الجو معتدل";
                    _displayColor = Colors.green;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
