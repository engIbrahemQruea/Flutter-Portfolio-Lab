// 1. كلاس حقيبة البيانات - يحسب الفارق تلقائياً في الباني تماماً ككودك
class TemperatureChangedEventArgs {
  final double oldTemperature;
  final double newTemperature;
  final double difference;

  TemperatureChangedEventArgs({
    required this.oldTemperature,
    required this.newTemperature,
  }) : difference = newTemperature - oldTemperature; // حساب الفارق تلقائياً هنا
}

// 2. كلاس الثرموستات (المستشعر والباعث)
class Thermostat {
  // تعريف الحدث (نستخدم Function بالمعايير القياسية لـ Dart)
  void Function(Object sender, TemperatureChangedEventArgs e)?
  temperatureChanged;

  double _oldTemperature = 0.0;
  double _currentTemperature = 0.0;

  void setTemperature(double newTemperature) {
    if (newTemperature != _currentTemperature) {
      _oldTemperature = _currentTemperature;
      _currentTemperature = newTemperature;

      // استدعاء دالة الـ Overload الأولى
      _onTemperatureChangedParameters(_oldTemperature, _currentTemperature);
    }
  }

  // الـ Overload الأول: يأخذ متغيرات عادية
  void _onTemperatureChangedParameters(double oldTemp, double currentTemp) {
    _onTemperatureChangedEvent(
      TemperatureChangedEventArgs(
        oldTemperature: oldTemp,
        newTemperature: currentTemp,
      ),
    );
  }

  // الـ Overload الثاني (دالة الحماية المركزية): يطلق الحدث الفعلي (Invoke)
  void _onTemperatureChangedEvent(TemperatureChangedEventArgs e) {
    if (temperatureChanged != null) {
      temperatureChanged!(
        this,
        e,
      ); // تمرير الـ sender (this) والـ EventArgs (e)
    }
  }
}

// 3. كلاس الشاشة الرقمية المستمعة للحدث
class Display {
  final List<String> logs = []; // سنستخدم مصفوفة لحفظ النصوص وعرضها في فلاتر

  // دالة الاشتراك (المكافئ لـ +=)
  void subscribe(Thermostat thermostat) {
    // 1. Assigning a function to a variable called First-Class Functions
    thermostat.temperatureChanged = handleTemperatureChange;
  }

  // دالة معالجة الحدث (المكافئ لـ HandleTemperatureChange)
  void handleTemperatureChange(Object sender, TemperatureChangedEventArgs e) {
    String log =
        "تم رصد تغير من مستشعر: ${sender.runtimeType}\n"
        "الحرارة السابقة: ${e.oldTemperature}°C\n"
        "الحرارة الحالية: ${e.newTemperature}°C\n"
        "الفارق: ${e.difference}°C\n"
        "--------------------------";
    logs.add(log);
    print(log); // للطباعة في الـ Console أيضاً
  }
}
