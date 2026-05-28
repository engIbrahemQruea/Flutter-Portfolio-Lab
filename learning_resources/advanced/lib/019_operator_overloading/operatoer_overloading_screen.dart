import 'package:flutter/material.dart';

/// 🏛️ كلاس النقطة الهندسي ثنائي الأبعاد بمفهوم الـ Operator Overloading في Dart
class CustomPoint {
  final int x;
  final int y;

  CustomPoint(this.x, this.y);

  // ➕ تحميل عامل الجمع + (يستقبل معاملاً واحداً فقط في Dart)
  CustomPoint operator +(CustomPoint other) {
    return CustomPoint(this.x + other.x, this.y + other.y);
  }

  // ➖ تحميل عامل الطرح -
  CustomPoint operator -(CustomPoint other) {
    return CustomPoint(this.x - other.x, this.y - other.y);
  }

  // 🤝 تحميل عامل التساوي ==
  // ملاحظة: في Dart، عند تحميل == يتم تلقائياً تفعيل الـ != بشكل فكري دون الحاجة لكتابته إجبارياً!
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CustomPoint && other.x == this.x && other.y == this.y;
  }

  // توليد الـ HashCode الخاص بالكائن (ممارسات هندسية قياسية عند تعديل عامل التساوي)
  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  // 📝 محاكاة دالة ToString() الخاصة بالسي شارب لشكل الإحداثيات الرياضي
  @override
  String toString() {
    return "($x, $y)";
  }
}

class PointScreen extends StatefulWidget {
  const PointScreen({super.key});

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  // إحداثيات النقطة الأولى الافتراضية (طابق كود C#)
  int _p1X = 1;
  int _p1Y = 2;
  // إحداثيات النقطة الثانية الافتراضية (طابق كود C#)
  int _p2X = 3;
  int _p2Y = 4;

  // متغيرات حفظ نتائج العمليات في الذاكرة
  late CustomPoint _point1;
  late CustomPoint _point2;
  CustomPoint? _point3; // الجمع
  CustomPoint? _point4; // الطرح
  bool? _isEqual;

  @override
  void initState() {
    super.initState();
    _calculateResults();
  }

  void _calculateResults() {
    setState(() {
      _point1 = CustomPoint(_p1X, _p1Y);
      _point2 = CustomPoint(_p2X, _p2Y);

      // استخدام العوامل المخصصة بشكل فطري غاية في النظافة والأناقة!
      _point3 = _point1 + _point2; // الجمع المطور
      _point4 = _point1 - _point2; // الطرح المطور
      _isEqual = (_point1 == _point2); // المقارنة المطورة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📐 Point Operator Overloading Matrix'),
        centerTitle: true,
        backgroundColor: const Color(0xFF161B22),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // لوحة التحكم وتغيير إحداثيات النقاط حياً
            _buildCoordControllers(),
            const SizedBox(height: 20),

            // 🖥️ مرآة شاشة المخرجات (تحاكي الـ Console بدقة بصرية)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF161B22),
                  borderRadius: BorderRadius.circular(12),
                  //   border: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.terminal,
                          color: Colors.cyanAccent,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Live UI Output Display",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey, height: 25),

                    _buildConsoleLine(
                      "Point1 : ",
                      _point1.toString(),
                      Colors.white,
                    ),
                    const SizedBox(height: 10),
                    _buildConsoleLine(
                      "Point2 : ",
                      _point2.toString(),
                      Colors.white,
                    ),
                    const SizedBox(height: 10),
                    _buildConsoleLine(
                      "Point3 (point1 + point2): ",
                      _point3.toString(),
                      Colors.greenAccent,
                    ),
                    const SizedBox(height: 10),
                    _buildConsoleLine(
                      "Point4 (point1 - point2): ",
                      _point4.toString(),
                      Colors.orangeAccent,
                    ),

                    const Divider(color: Colors.grey, height: 30),

                    // طباعة نتائج المقارنة المنطقية باستخدام العوامل المطورة
                    const Text(
                      "Logical Operator Results:",
                      style: TextStyle(
                        fontFamily: 'Courier',
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isEqual!
                          ? "Using == : Yes, Point1 = Point2"
                          : "Using == : No, Point1 does not equal Point2",
                      style: TextStyle(
                        fontFamily: 'Courier',
                        color: _isEqual! ? Colors.green : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      !_isEqual!
                          ? "Using != : Yes, Point1 does not equal Point2"
                          : "Using != : No, Point1 = Point2",
                      style: TextStyle(
                        fontFamily: 'Courier',
                        color: !_isEqual! ? Colors.green : Colors.redAccent,
                        fontWeight: FontWeight.bold,
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

  // ويدجت لبناء أزرار التحكم في الإحداثيات بشكل تفاعلي مرن
  Widget _buildCoordControllers() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF21262D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPointCounter(
                "Point 1 (X)",
                _p1X,
                (val) => setState(() {
                  _p1X = val;
                  _calculateResults();
                }),
              ),
              _buildPointCounter(
                "Point 1 (Y)",
                _p1Y,
                (val) => setState(() {
                  _p1Y = val;
                  _calculateResults();
                }),
              ),
            ],
          ),
          const Divider(color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPointCounter(
                "Point 2 (X)",
                _p2X,
                (val) => setState(() {
                  _p2X = val;
                  _calculateResults();
                }),
              ),
              _buildPointCounter(
                "Point 2 (Y)",
                _p2Y,
                (val) => setState(() {
                  _p2Y = val;
                  _calculateResults();
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointCounter(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.blueAccent),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () => onChanged(value - 1),
            ),
            Text(
              "$value",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConsoleLine(String prefix, String value, Color valueColor) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontFamily: 'Courier', fontSize: 14),
        children: [
          TextSpan(
            text: prefix,
            style: const TextStyle(color: Colors.grey),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: valueColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
