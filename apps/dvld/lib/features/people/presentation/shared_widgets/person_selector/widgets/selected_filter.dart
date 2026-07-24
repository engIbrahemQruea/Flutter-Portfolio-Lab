import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/enums/filter_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedFilterDropdownButton extends StatelessWidget {
  const SelectedFilterDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: DropdownMenuFormField(
        label: const Text('Filter Type'),
        textStyle: Theme.of(context).textTheme.titleMedium,
        onSelected: (value) {
          context.read<PersonSelectorCubit>().onSelectedFilterType(value!);
        },
        dropdownMenuEntries: [
          DropdownMenuEntry(
            label: 'Person ID',
            value: EnFilterType.personID.name,
          ),
          DropdownMenuEntry(
            label: 'National No',
            value: EnFilterType.nationalNo.name,
          ),
        ],
      ),
    );
  }
}
