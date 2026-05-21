import 'package:flutter/material.dart';

// هذا هو الـ User Control الخاص بنا
class UserCardWidget extends StatelessWidget {
  // الخصائص التي يتعرض لها العنصر من الخارج (Expose Properties)
  final String imageUrl;
  final String name;
  final String role;
  final VoidCallback? onProfileTap; // ديليجيت للضغط

  const UserCardWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.role,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    // تصميم الواجهة المصغرة داخل الـ User Control
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    role,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: onProfileTap, // استدعاء الحدث العكسي عند الضغط
            ),
          ],
        ),
      ),
    );
  }
}
