import 'package:flutter/material.dart';

class DetailsScreenFour extends StatelessWidget {
  final int? userId;
  final String? userName;

  // 1. المشيد الافتراضي (الأساسي) - نجعله خاصاً أو نتركه اختيارياً
  const DetailsScreenFour({super.key, this.userId, this.userName});

  // 2. المشيد المسمى الأول: خاص بالـ ID فقط (المكافئ لـ Constructor 1 في #C)
  const DetailsScreenFour.fromId(int id, {super.key}) 
      : userId = id, 
        userName = null;

  // 3. المشيد المسمى الثاني: خاص بالاسم فقط (المكافئ لـ Constructor 2 في #C)
  const DetailsScreenFour.fromName(String name, {super.key}) 
      : userId = null, 
        userName = name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: userId != null 
            ? Text('Opened using ID: $userId') 
            : Text('Opened using Name: $userName'),
      ),
    );
  }
}