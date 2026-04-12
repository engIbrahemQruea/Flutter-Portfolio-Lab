import 'package:flutter/material.dart';

class TicTacToeGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. إعداد القلم (Paint Object)
    // نستخدم اللون الأبيض وسمك مناسب ليحاكي الصورة
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth =
          10.0 // سمك الخطوط (Thick Grid lines)
      ..style = PaintingStyle.stroke; // رسم إطار خارجي فقط

    // 2. هندسة الأبعاد (Dimensions logic)
    // نقسم العرض والارتفاع إلى 3 أجزاء متساوية
    double cellWidth = size.width / 3;
    double cellHeight = size.height / 3;

    // --- رسم الخطوط العمودية (Vertical Lines) ---
    // نقفز بمسافة ثلث العرض في كل مرة
    for (int i = 1; i <= 2; i++) {
      double x = cellWidth * i;
      canvas.drawLine(
        Offset(x, 0), // نقطة البداية (Top)
        Offset(x, size.height), // نقطة النهاية (Bottom)
        paint,
      );
    }

    // --- رسم الخطوط الأفقية (Horizontal Lines) ---
    // نقفز بمسافة ثلث الارتفاع في كل مرة
    for (int i = 1; i <= 2; i++) {
      double y = cellHeight * i;
      canvas.drawLine(
        Offset(0, y), // نقطة البداية (Left)
        Offset(size.width, y), // نقطة النهاية (Right)
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
