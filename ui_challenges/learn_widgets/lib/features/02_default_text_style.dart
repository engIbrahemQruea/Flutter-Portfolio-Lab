// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DefaultTextStyleWidget extends StatelessWidget {
  const DefaultTextStyleWidget({
    Key? key,
    required this.title,
    this.titleColor,
    required this.description,
    this.descriptionColor,
  }) : super(key: key);

  final String title;
  // 3
  final Color? titleColor;
  final String description;
  // 4
  final Color? descriptionColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DefaultTextStyle Widget')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(title)],
        ),
      ),
    );
  }
}
