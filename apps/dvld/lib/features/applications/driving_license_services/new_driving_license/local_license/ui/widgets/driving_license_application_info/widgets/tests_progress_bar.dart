import 'package:flutter/material.dart';

class TestsProgressBar extends StatelessWidget {
  final int passed;
  final int total;

  const TestsProgressBar({
    super.key,
    required this.passed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final allPassed = passed >= total && total > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pass Tests Count ',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
            Text(
              allPassed
                  ? 'Complete ✓ ($passed From $total)'
                  : '$passed From $total',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: allPassed ? const Color(0xFF1E9E5A) : Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: List.generate(total, (i) {
            final done = i < passed;
            return Expanded(
              child: Container(
                height: 6,
                margin: EdgeInsets.only(left: i < total + 1 ? 6 : 0),
                decoration: BoxDecoration(
                  color: done
                      ? const Color(0xFF1E9E5A)
                      : const Color(0xFFE3E6F0),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
