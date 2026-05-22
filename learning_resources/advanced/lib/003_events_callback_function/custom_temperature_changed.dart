// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TemperatureChangedEventArgs {
  final double oldTemp;
  final double newTemp;

  TemperatureChangedEventArgs({required this.oldTemp, required this.newTemp});

  get diffTemp => newTemp - oldTemp;
}

class CustomTemperatureChanged extends StatefulWidget {
  final void Function(TemperatureChangedEventArgs args)? onTemperatureChanged;

  CustomTemperatureChanged({Key? key, this.onTemperatureChanged})
    : super(key: key);

  @override
  State<CustomTemperatureChanged> createState() =>
      _CustomTemperatureChangedState();
}

class _CustomTemperatureChangedState extends State<CustomTemperatureChanged> {
  final TextEditingController _number1Controller = TextEditingController();

  double _currentTemp = 0.0;

  void _raiseTemperature(double oldTemp, double newTemp) {
    if (widget.onTemperatureChanged != null) {
      widget.onTemperatureChanged!(
        TemperatureChangedEventArgs(oldTemp: oldTemp, newTemp: newTemp),
      );
    }
  }

  void _updateTemp() {
    double newTemp = double.tryParse(_number1Controller.text) ?? 0.0;

    if ((_currentTemp - newTemp).abs() >= 0.1) {
      double oldTemp = _currentTemp;
      setState(() {
        _currentTemp = newTemp;
      });
      _raiseTemperature(oldTemp, newTemp);
    }
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

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _updateTemp,
            child: const Text('Calculate'),
          ),
          const SizedBox(height: 16),
          // عرض النتيجة داخل المكون
          Text(
            'Result: $_currentTemp',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class TemperatureSensorComponent extends StatefulWidget {
  // تعريف الحدث القياسي
  final void Function(TemperatureChangedEventArgs e)? onTemperatureChanged;

  const TemperatureSensorComponent({super.key, this.onTemperatureChanged});

  @override
  State<TemperatureSensorComponent> createState() =>
      _TemperatureSensorComponentState();
}

class _TemperatureSensorComponentState
    extends State<TemperatureSensorComponent> {
  double _currentTemperature = 25.0;

  // دالة البث المركزية (المكافئ لـ RaiseOnTemperatureChanged)
  void _raiseOnTemperatureChanged(double oldTemp, double newTemp) {
    if (widget.onTemperatureChanged != null) {
      widget.onTemperatureChanged!(
        TemperatureChangedEventArgs(oldTemp: oldTemp, newTemp: newTemp),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '🎛️ لوحة تحكم المستشعر (Component)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'درجة الحرارة الحالية: ${_currentTemperature.toStringAsFixed(1)} °C',
              style: const TextStyle(fontSize: 15),
            ),
            // سلايدر لمحاكاة تغير الحرارة من المستشعر
            Slider(
              value: _currentTemperature,
              min: 0,
              max: 50,
              divisions: 50,
              label: _currentTemperature.round().toString(),
              onChanged: (newValue) {
                double oldTemp = _currentTemperature;
                setState(() {
                  _currentTemperature = newValue;
                });

                // استدعاء دالة البث الموحدة لإخطار الشاشة الخارجية فوراً
                _raiseOnTemperatureChanged(oldTemp, newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
