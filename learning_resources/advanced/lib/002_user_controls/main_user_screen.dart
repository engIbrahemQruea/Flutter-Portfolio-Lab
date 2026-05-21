import 'package:advanced/002_user_controls/custom_user_card_widget.dart';
import 'package:flutter/material.dart';

class MainUserScreen extends StatelessWidget {
  const MainUserScreen({super.key});

  // داخل شاشة قائمة الموظفين مثلاً:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('قائمة الموظفين')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // استدعاء الـ User Control وتمرير البيانات له عبر الخصائص
          UserCardWidget(
            imageUrl: 'https://api.dicebear.com/7.x/bottts/svg?seed=Ibrahim',
            name: 'إبراهيم قريع',
            role: 'مهندس برمجيات محترف',
            onProfileTap: () => print('الانتقال لبروفايل إبراهيم'),
          ),

          UserCardWidget(
            imageUrl: 'https://api.dicebear.com/7.x/bottts/svg?seed=Ahmed',
            name: 'أحمد صالح',
            role: 'مدير النظام',
            onProfileTap: () => print('الانتقال لبروفايل أحمد'),
          ),

          UserCardWidget(
            imageUrl: 'https://api.dicebear.com/7.x/bottts/svg?seed=Sara',
            name: 'سارة محمد',
            role: 'مصممة واجهات المستخدم',
            onProfileTap: () => print('الانتقال لبروفايل سارة'),
          ),
        ],
      ),
    );
  }
}
