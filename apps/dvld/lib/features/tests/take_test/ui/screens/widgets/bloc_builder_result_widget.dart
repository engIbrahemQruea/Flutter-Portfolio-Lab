import 'package:dvld/features/tests/take_test/ui/logic/take_test_cubit/take_test_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocBuilderResultRowWidget extends StatelessWidget {
  const BlocBuilderResultRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TakeTestCubit, TakeTestCubitState>(
      buildWhen: (previous, current) =>
          previous.selectedResultTest != current.selectedResultTest ||
          previous.isLucked != current.isLucked,
      builder: (context, state) {
        return Row(
          children: [
            const Text('Result:', style: TextStyle(fontSize: 16)),
            IgnorePointer(
              ignoring: state.isLucked,
              child: RadioGroup<bool>(
                groupValue: state.selectedResultTest,
                onChanged: (value) =>
                  context.read<TakeTestCubit>().onChangeRadioOption(value!),
                
                child: SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          value: true,
                          title: const Text('Pass'),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: false,
                          title: const Text('Fail'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            state.isLucked
                ? const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '⚠️ Person already sat for this test, results are locked.',
                      style: TextStyle(color: Colors.orange),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
