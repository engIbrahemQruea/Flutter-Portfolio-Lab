import 'package:dvld/features/tests/schedule_test/ui/screens/bloc_consumer_schedule_test.dart';
import 'package:flutter/material.dart';

class ScheduleTestWidgetScreen extends StatelessWidget {
  const ScheduleTestWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Test'), centerTitle: true),
      body: Padding(
        padding: const .symmetric(horizontal: 14, vertical: 10),
        child: Center(child: BlocConsumerScheduleTest()),
      ),
    );
  }
}
