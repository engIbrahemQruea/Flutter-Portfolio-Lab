import 'dart:io';

import 'package:flutter/material.dart';

class PersonAvatar extends StatelessWidget {
  final String? imagePath;
  final int? gender;
  final double size;

  const PersonAvatar({
    super.key,
    required this.imagePath,
    this.size = 170,
    this.gender,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && File(imagePath!).existsSync();

    return Container(
      width: size,
      height: size * 1.15,
      decoration: BoxDecoration(
        color: const Color(0xFFE9E6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E0FA), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: hasImage
            ? Image.file(
                File(imagePath!),
                fit: BoxFit.cover,

                errorBuilder: (_, _, _) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() => Center(
    child: Icon(
      gender == 0 ? Icons.person : Icons.person_2,
      size: size * 0.5,
      color: const Color(0xFF6A5AE0),
    ),
  );
}
