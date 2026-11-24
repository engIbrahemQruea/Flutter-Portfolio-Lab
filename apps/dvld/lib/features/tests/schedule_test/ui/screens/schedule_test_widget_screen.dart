import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_creation_mode.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:dvld/features/tests/schedule_test/ui/logic/schedule_test/schedule_test_cubit.dart';
import 'package:dvld/features/tests/schedule_test/ui/screens/bloc_consumer_schedule_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleTestWidgetScreen extends StatelessWidget {
  const ScheduleTestWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            BlocSelector<
              ScheduleTestCubit,
              ScheduleTestCubitState,
              ScheduleTestInfoEntity?
            >(
              selector: (state) {
                return state is ScheduleTestLoaded ? state.info : null;
              },
              builder: (context, state) {
                final String title =
                    state?.scheduleTestCreationMode ==
                        ScheduleTestCreationMode.firstTime
                    ? 'Schedule Test'
                    : 'Schedule Retake Test';
                return Text(title ?? 'Schedule Test');
              },
            ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const .symmetric(horizontal: 14, vertical: 10),
        child: Center(child: BlocConsumerScheduleTest()),
      ),
    );
  }
}
