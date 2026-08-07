import 'package:dvld/features/manage_users/presentation/helpers/enum_users_filter_option.dart';
import 'package:dvld/features/manage_users/presentation/logic/cubit/manage_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsActiveOptionDropDownMenuFieldWidget extends StatelessWidget {
  const IsActiveOptionDropDownMenuFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField<IsActiveOption>(
      initialSelection: IsActiveOption.all,
      dropdownMenuEntries: IsActiveOption.values
          .map(
            (option) => DropdownMenuEntry(value: option, label: option.label),
          )
          .toList(),
      onSelected: (newOption) => context
          .read<ManageUsersCubit>()
          .onSelectedFilterIsActiveOption(newOption!),
    );
  }
}
