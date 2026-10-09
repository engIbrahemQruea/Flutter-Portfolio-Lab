import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/tests/take_test/ui/logic/take_test_cubit/take_test_cubit.dart';
import 'package:dvld/features/tests/take_test/ui/screens/widgets/bloc_builder_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakeTestInfo extends StatefulWidget {
  const TakeTestInfo({super.key});

  @override
  State<TakeTestInfo> createState() => _TakeTestInfoState();
}

class _TakeTestInfoState extends State<TakeTestInfo> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _notesController.text = context.read<TakeTestCubit>().state.notes ?? "";
  }

  @override
  dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        BlocBuilderResultRowWidget(),

        AppTextField(
          label: 'Notes',
          hintText: 'Enter notes here...',
          maxLines: 2,
          maxLength: 200,
          controller: _notesController,
          onChanged: (value) =>
              context.read<TakeTestCubit>().onChangeNotes(value),
        ),
      ],
    );
  }
}
