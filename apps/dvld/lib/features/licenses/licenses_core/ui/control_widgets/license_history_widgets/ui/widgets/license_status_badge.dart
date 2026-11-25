import 'package:flutter/material.dart';

class LicenseStatusBadge extends StatelessWidget {
  final bool isActive;
  final bool isExpired;

  const LicenseStatusBadge({
    super.key,
    required this.isActive,
    required this.isExpired,
  });

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = !isActive
        ? ('Not Active', const Color(0xFFD33F49), const Color(0xFFFDECEE))
        : isExpired
        ? ('Expired', const Color(0xFFE8A13A), const Color(0xFFFDF3E3))
        : ('Active ✓', const Color(0xFF1E9E5A), const Color(0xFFE7F8EE));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
