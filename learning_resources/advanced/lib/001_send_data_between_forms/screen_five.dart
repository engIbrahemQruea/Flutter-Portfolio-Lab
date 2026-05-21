import 'package:flutter/material.dart';

class ModernDetailsScreenFive extends StatelessWidget {
  final int? userId;
  final String? userName;

  const ModernDetailsScreenFive({super.key, this.userId, this.userName})
    : assert(
        (userId != null && userName == null) ||
            (userId == null && userName != null),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: userId != null
            ? Text('Opened using ID: $userId')
            : Text('Opened using Name: $userName'),
      ),
    );
  }
}
