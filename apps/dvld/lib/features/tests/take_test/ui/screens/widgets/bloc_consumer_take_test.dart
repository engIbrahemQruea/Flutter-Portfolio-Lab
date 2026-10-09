import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/tests/take_test/ui/logic/take_test_cubit/take_test_cubit.dart';
import 'package:dvld/features/tests/take_test/ui/screens/widgets/save_close_take_test_widget.dart';
import 'package:dvld/features/tests/take_test/ui/screens/widgets/scheduled_test_info_card.dart';
import 'package:dvld/features/tests/take_test/ui/screens/widgets/take_test_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocConsumerTakeTest extends StatelessWidget {
  const BlocConsumerTakeTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TakeTestCubit, TakeTestCubitState>(
      listener: (context, state) {
        if (state.takeTestStatus.isSuccess) {
          AppDialogs.showSuccess(
            context: context,
            title: 'Success ',
            message: 'Test saved successfully',
            buttonText: 'OK',
            onPressed: () => context.pop(),
          );
        }
        if (state.takeTestStatus.isFailure) {
          AppDialogs.showFailure(
            context: context,
            title: 'Error ',
            message: state.errorMessage ?? 'Failed to save test',
            buttonText: 'OK',
            onPressed: () => context.pop(),
          );
        }
      },
      builder: (context, state) {
        if (state.takeTestStatus.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.takeTestStatus.isFailure) {
          return Center(
            child: Text(
              state.errorMessage ?? 'Failed to save test',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final takeTestInfo = (state.takeTestStatus.isLoaded)
            ? state.takeTestInfoEntity
            : null;
        return Column(
          spacing: 16,
          children: [
            ScheduledTestInfoCard( takeTestInfo: takeTestInfo!),
            TakeTestInfo(),

            SaveCloseTakeTestWidget(),
          ],
        );
      },
    );
  }
}
