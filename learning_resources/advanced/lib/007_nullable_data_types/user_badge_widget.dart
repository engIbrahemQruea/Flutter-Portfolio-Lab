import 'package:flutter/material.dart';

class UserBadgeWidget extends StatelessWidget {
  final String name;
  final int? age; // معامل يقبل الـ Null تماماً مثل int? في C#

  const UserBadgeWidget({
    super.key,
    required this.name,
    this.age, // اختياري، إذا لم يمرر سيكون null
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: Icon(
          Icons.account_circle,
          size: 40,
          color: age != null ? Colors.blue.shade700 : Colors.grey,
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        // 🎯 هنا فحص الـ Null تماماً مثل (if Age.HasValue) في كود المدرب
        subtitle: Text(
          age != null ? 'العمر الموثق: $age سنة' : 'العمر: غير متوفر بالملف ⚠️',
          style: TextStyle(
            color: age != null ? Colors.black87 : Colors.red.shade700,
            fontStyle: age != null ? FontStyle.normal : FontStyle.italic,
          ),
        ),
        trailing: age != null
            ? Chip(
                label: const Text('نشط'),
                backgroundColor: Colors.blue.shade50,
              )
            : Chip(
                label: const Text('معلق'),
                backgroundColor: Colors.amber.shade50,
              ),
      ),
    );
  }
}
