import 'package:advanced/007_nullable_data_types/user_badge_widget.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الأعضاء (محاكاة كود المدرب)'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'استدعاء الويدجت بقيم مختلفة (مع وبدون عمر):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 12),

            // محاكاة استدعاءات دالة Main في كود المدرب 🎯
            const UserBadgeWidget(
              name: "Mohammed Abu-Hadhoud",
              age: null,
            ), // العمر مفقود
            const UserBadgeWidget(name: "Ali Ahmed", age: 35), // العمر موجود
            const UserBadgeWidget(name: "Abdullah", age: null), // العمر مفقود
          ],
        ),
      ),
    );
  }
}
