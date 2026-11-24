// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:dvld/features/tests/schedule_test/ui/logic/schedule_test/schedule_test_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleTestSaveButton extends StatelessWidget {
  const ScheduleTestSaveButton({super.key, required this.info});

  final ScheduleTestInfoEntity info;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        AppButton.icon(
          icon: Icon(Icons.cancel_rounded, color: Colors.red),
          label: 'Close',
          onPressed: () => context.pop(),
        ),
        AppButton.custom(
          label: 'Save',
          onPressed: !info.canSchedule
              ? null
              : () => context.read<ScheduleTestCubit>().saveAppointment(),
        ),
      ],
    );
  }
}
