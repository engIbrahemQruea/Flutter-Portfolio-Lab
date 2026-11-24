import 'package:flutter/material.dart';

class InfoTileWidget extends StatelessWidget {
  const InfoTileWidget({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.wide = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool wide;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? double.infinity : 200,
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10.5, color: Color(0xFF8A8FA3)),
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Color(0xFF23203F),
            ),
          ),
        ],
      ),
    );
  }
}
