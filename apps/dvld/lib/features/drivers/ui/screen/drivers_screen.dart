import 'package:dvld/features/drivers/ui/screen/widgets/drivers_table.dart';
import 'package:flutter/material.dart';

class DriversScreen extends StatelessWidget {
  const DriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Drivers'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SafeArea(child: SingleChildScrollView(child: DriversTable())),
      ),
    );
  }
}
