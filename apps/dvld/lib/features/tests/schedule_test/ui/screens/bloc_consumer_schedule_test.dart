// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      listener: (context, state) {
        if (state is ScheduleTestSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
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
          ScheduleTestLoaded(:final info, :final selectedDate) => _buildForm(
            context,
            info,
          ),
        };
      },
    );
  }
}

Widget _buildForm(BuildContext context, ScheduleTestInfoEntity info) {
  final constraintMessage = switch (info.constraint) {
    NoConstraintViolated() => null,
    ActiveAppointmentExistsConstraint() =>
      "Person Already has an active appointment for this test",
    AppointmentLockedConstraint() =>
      "Person already sat for the test, appointment locked.",
    PrerequisiteTestNotPassedConstraint(:final requiredTest) =>
      "Cannot Schedule, ${requiredTest.name} should be passed first",
  };

  return Column(
    spacing: 10,
    crossAxisAlignment: .center,

    children: [
      if (constraintMessage != null)
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.red.shade100,
          child: Text(
            constraintMessage,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ScheduleTestInfo(
        info: info,
      ),

      RetakeTestInfo(testAppointment: info,),
      ScheduleTestSaveButton(),
    ],
  );
}
