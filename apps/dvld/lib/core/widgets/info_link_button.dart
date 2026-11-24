import 'package:flutter/material.dart';

class InfoLinkButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const InfoLinkButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          '$label ↗',
          style: const TextStyle(
            color: Color(0xFF6A5AE0),
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
          ),
        ),
      ),
    );
  }
}
