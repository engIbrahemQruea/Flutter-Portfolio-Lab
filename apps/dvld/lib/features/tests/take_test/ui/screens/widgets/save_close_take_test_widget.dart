import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/tests/take_test/ui/logic/take_test_cubit/take_test_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveCloseTakeTestWidget extends StatelessWidget {
  const SaveCloseTakeTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isLocked = context.select(
      (TakeTestCubit cubit) => cubit.state.isLucked,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 10,
      children: [
        AppButton.icon(
          label: 'Close',
          icon: Icon(Icons.close, color: Colors.red),
          onPressed: () => context.pop(),
        ),
        AppButton.custom(
          label: 'Save',
          icon: const Icon(Icons.save, color: Colors.green),
          onPressed: isLocked
              ? null
              : () async {
                  final result = await AppDialogs.showConfirmation(
                    context: context,
                    title: 'Confirm Save',
                    confirmText: 'Yes',
                    cancelText: 'No',
                    confirmColor: Colors.green,
                    message: 'Are you sure you want to save the test?',
                  );

                  if (result case true when context.mounted) {
                    await context.read<TakeTestCubit>().saveTakeTest();
                  }
                },
        ),
      ],
    );
  }
}
