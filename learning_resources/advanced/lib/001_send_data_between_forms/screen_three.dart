import 'package:flutter/material.dart';
// الشاشة المستقبلة تقبل سطر بيانات واحد (Record)

class ProfileScreenThree extends StatelessWidget {
  // تعريف الـ Record هنا كنوع بيانات ممرر
  final ({int id, String name, bool isAdmin}) userData;

  const ProfileScreenThree({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Using Record'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('ID: ${userData.id}'),
          Text('Name: ${userData.name}'),
          Text('Role: ${userData.isAdmin ? "Admin" : "User"}'),
        ],
      ),
    );
  }
}
