import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/features/manage_users/presentation/helpers/enum_users_filter_option.dart';
import 'package:dvld/features/manage_users/presentation/logic/cubit/manage_users_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/widgets/search_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FilterUsersBy extends StatelessWidget {
  const FilterUsersBy({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageUsersCubit>();
    return Row(
      children: [
        Text('Filter By: '),
        horizontalSpace(10),
        SizedBox(
          width: 200,
          child: DropdownMenuFormField(
            initialSelection: EnUsersFilterOption.none,
            dropdownMenuEntries: EnUsersFilterOption.values
                .map(
                  (option) =>
                      DropdownMenuEntry(value: option, label: option.label),
                )
                .toList(),
            onSelected: (newOption) => cubit.onChangeFilterOption(newOption!),
          ),
        ),

        SearchTextFormField(),

        Spacer(),
        IconButton.outlined(
          tooltip: 'Add User',
          onPressed: () async {
            final isAdded = await context.pushNamed<bool>(
              DRoutes.addUpdateUsersScreen,
            );
            // if (isAdded == true && context.mounted) {
            //   context.read<GetAllPeopleCubit>().getAllPeople();
            // }
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
