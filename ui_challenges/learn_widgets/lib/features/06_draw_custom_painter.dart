import 'package:flutter/material.dart';

class DrawCustomPainter extends StatelessWidget {
  const DrawCustomPainter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Draw Custom Painter')),
      body: Center(
        child: Container(
          width: 400,
          height: 500,
          color: Colors.grey[200], // خلفية لنرى الرسم عليها
          child: CustomPaint(
            painter: MyPainter(), // الـ Painter الذي أنشأناه
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final paint = Paint()
    //   ..color = Colors.blue
    //   ..style = PaintingStyle.fill;

    // // رسم مستطيل
    // canvas.drawRect(Rect.fromLTWH(50, 50, 200, 100), paint);

    // // رسم دائرة
    // canvas.drawCircle(Offset(150, 250), 50, paint);

    final paint = Paint()
      ..color = Colors
          .blue // لون الخط
      ..strokeWidth =
          5.0 // سمك الخط (مثل PenWidth في C#)
      ..strokeCap = StrokeCap.round; // شكل نهاية الخط (دائري، حاد، إلخ)

    // 2. تحديد النقاط
    const p1 = Offset(50, 50); // نقطة البداية (x1, y1)
    final p2 = Offset(
      size.width - 50,
      size.height - 50,
    ); // نقطة النهاية ديناميكية

    // 3. أمر الرسم على الـ Canvas
    canvas.drawLine(p1, p2, paint);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 30, paint);

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 100,
        height: 50,
      ),
      paint,
    );

    final paintShap = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke; // Stroke للرسم الخارجي، Fill للتعبئة

    // --- رسم الخط (Line) ---
    // يحتاج نقطة بداية ونقطة نهاية وقلم
    canvas.drawLine(
      const Offset(20, 20),
      Offset(size.width - 20, 20),
      paintShap..color = Colors.red, // نغير اللون للخط فقط
    );

    // --- رسم المستطيل (Rectangle) ---
    // يحتاج تعريف Rect (من اليسار، الأعلى، العرض، الطول)
    Rect rect = Rect.fromLTWH(20, 60, size.width - 40, 80);
    canvas.drawRect(
      rect,
      paint..color = Colors.green, // نغير اللون للمستطيل
    );

    // --- رسم الشكل البيضاوي (Ellipse) ---
    // في الجرافيكس، الـ Ellipse هو دائرة تُرسَم داخل مستطيل وهمي (Bounding Box)
    Rect ellipseRect = Rect.fromLTWH(20, 160, size.width - 40, 100);
    canvas.drawOval(
      ellipseRect,
      paint..color = Colors.orange, // نغير اللون للبيضاوي
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
