// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class StatusPillWidget extends StatelessWidget {
  const StatusPillWidget({super.key, required this.text, required this.ok});

  final String text;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: ok ? Color(0xFFE7F8EE) : Color(0xFFF1F2F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: ok ? Color(0xFF1E9E5A) : Color(0xFF7A7F93),
        ),
      ),
    );
  }
}
