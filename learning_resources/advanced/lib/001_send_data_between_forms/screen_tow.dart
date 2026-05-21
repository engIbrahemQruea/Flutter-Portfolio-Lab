import 'package:flutter/material.dart';
// الشاشة المستقبلة

class DetailsScreenTow extends StatelessWidget {
  final int userId;
  final String userName;

  // استخدام الـ Named Parameters والـ Required لضمان الأمان
  const DetailsScreenTow({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Two'), centerTitle: true),
      body: Center(child: Text('Welcome $userName (ID: $userId)')),
    );
  }
}
