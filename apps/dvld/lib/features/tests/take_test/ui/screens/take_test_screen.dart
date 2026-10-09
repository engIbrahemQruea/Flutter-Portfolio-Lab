import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/tests/take_test/ui/screens/widgets/bloc_consumer_take_test.dart';
import 'package:dvld/features/tests/take_test/ui/screens/widgets/scheduled_test_info_card.dart';
import 'package:dvld/features/tests/take_test/ui/screens/widgets/take_test_info.dart';
import 'package:flutter/material.dart';

enum ResultTest { Pass, Fail }

class TakeTestScreen extends StatelessWidget {
  const TakeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take Test'), centerTitle: true),
      body: Center(
        child: SizedBox(
          width: 700,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: BlocConsumerTakeTest(),
          ),
        ),
      ),
    );
  }
}
