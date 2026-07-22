import 'package:flutter/material.dart';

class PersonImage extends StatelessWidget {
  const PersonImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 35,
      children: [
        RichText(
          text: TextSpan(
            text: 'Edit Person Info',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 16,
              decorationColor: Colors.red,
              decorationThickness: 2.0,
            ),
          ),
        ),
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: const Icon(Icons.person, size: 50, color: Colors.grey),

          // ? Image.file(
          //     File(imagePath),
          //     fit: BoxFit.cover,
          //     errorBuilder: (context, error, stackTrace) =>
          //         const Icon(
          //           Icons.broken_image,
          //           size: 50,
          //           color: Colors.grey,
          //         ),
          //   )
        ),
      ],
    );
  }
}
