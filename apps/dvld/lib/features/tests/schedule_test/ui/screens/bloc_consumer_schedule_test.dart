// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_constraints.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:dvld/features/tests/schedule_test/ui/logic/schedule_test/schedule_test_cubit.dart';
import 'package:dvld/features/tests/schedule_test/ui/screens/schedule_test_info.dart';
import 'package:dvld/features/tests/schedule_test/ui/screens/widgets/retake_test_info.dart';
import 'package:dvld/features/tests/schedule_test/ui/screens/widgets/schedule_test_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocConsumerScheduleTest extends StatelessWidget {
  const BlocConsumerScheduleTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleTestCubit, ScheduleTestCubitState>(
      listener: (context, state) async {
        if (state is ScheduleTestSuccess) {
          final messenger = ScaffoldMessenger.of(context);
          messenger.clearSnackBars();
          await messenger
              .showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(milliseconds: 900),
                ),
              )
              .closed;

          if (!context.mounted) return;
          context.pop(true);
        }
      },
      builder: (context, state) {
        return switch (state) {
          ScheduleTestInitial() || ScheduleTestLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          ScheduleTestFailure(:final errorMessage) => Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          ScheduleTestSubmitting() => const Center(
            child: CircularProgressIndicator(),
          ),
          ScheduleTestSuccess(:final message) => Center(child: Text(message)),
          ScheduleTestLoaded(:final info) => _buildForm(context, info),
        };
      },
    );
  }
}

Widget _buildForm(BuildContext context, ScheduleTestInfoEntity info) {
  return Column(
    spacing: 10,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      if (info.constraint.blockingMessage case final message?)
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.red.shade100,
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ScheduleTestInfo(info: info),
      RetakeTestInfo(info: info),
      ScheduleTestSaveButton(info: info),
    ],
  );
}
