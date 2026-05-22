import 'package:advanced/003_events_callback_function/temp_example_callback/thermostat_logic.dart';
import 'package:flutter/material.dart';

class ThermostatScreen extends StatefulWidget {
  const ThermostatScreen({super.key});

  @override
  State<ThermostatScreen> createState() => _ThermostatScreenState();
}

class _ThermostatScreenState extends State<ThermostatScreen> {
  // تعريف الكائنات تماماً كما في دالة Main في C#
  final Thermostat _thermostat = Thermostat();
  final Display _display = Display();

  @override
  void initState() {
    super.initState();
    // تنفيذ عملية الاشتراك عند بدء تشغيل الشاشة (display.Subscribe(thermostat);)
    _display.subscribe(_thermostat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('محاكي نظام الثرموستات القياسي')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'اضغط على الأزرار لمحاكاة SetTemperature بأرقام مختلفة وتأمل النتيجة المطبوعة:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // صف يحتوي على أزرار لإرسال درجات حرارة مختلفة (تطابق الـ Main الخاص بك)
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      setState(() => _thermostat.setTemperature(25)),
                  child: const Text('Set 25°C'),
                ),
                ElevatedButton(
                  // عند تكرار الضغط هنا، لن يحدث شيء لأن الشرط يحمي الكود من التكرار
                  onPressed: () =>
                      setState(() => _thermostat.setTemperature(30)),
                  child: const Text('Set 30°C (كررني)'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => _thermostat.setTemperature(35)),
                  child: const Text('Set 35°C'),
                ),
              ],
            ),
            const SizedBox(height: 25),

            const Text(
              '🖥️ شاشة عرض السجلات (Display Logs):',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // عرض السجلات التي استقبلها كلاس Display ديناميكياً على الشاشة
            Expanded(
              child: _display.logs.isEmpty
                  ? const Center(child: Text('لم يتم إرسال أي درجة حرارة بعد.'))
                  : ListView.builder(
                      itemCount: _display.logs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          color: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              _display.logs[index],
                              style: const TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 13,
                              ),
                            ),
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
