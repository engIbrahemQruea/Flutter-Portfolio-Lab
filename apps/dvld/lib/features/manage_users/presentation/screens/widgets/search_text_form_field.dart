import 'package:dvld/features/manage_users/presentation/helpers/enum_users_filter_option.dart';
import 'package:dvld/features/manage_users/presentation/logic/cubit/manage_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({super.key});

  TextInputType _getKeyboardType(EnUsersFilterOption filter) =>
      switch (filter) {
        EnUsersFilterOption.userID => const TextInputType.numberWithOptions(
          decimal: false,
        ),
        EnUsersFilterOption.personID => const TextInputType.numberWithOptions(
          decimal: false,
        ),
        EnUsersFilterOption.userName => TextInputType.text,
        EnUsersFilterOption.password => TextInputType.name,
        EnUsersFilterOption.isActive => TextInputType.none,
        EnUsersFilterOption.none => TextInputType.none,
      };

  List<TextInputFormatter> _getInputFormatters(EnUsersFilterOption filter) =>
      switch (filter) {
        EnUsersFilterOption.userID => [FilteringTextInputFormatter.digitsOnly],
        EnUsersFilterOption.personID => [
          FilteringTextInputFormatter.digitsOnly,
        ],
        EnUsersFilterOption.userName => [
          FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),
        ],
        EnUsersFilterOption.isActive ||
        EnUsersFilterOption.password ||
        EnUsersFilterOption.none => [],
      };

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageUsersCubit>();
    return BlocBuilder<ManageUsersCubit, ManageUsersCubitState>(
      buildWhen: (previous, current) =>
          previous.searchQuery != current.searchQuery ||
          previous.selectedFilterOption != current.selectedFilterOption,
      builder: (context, state) {
        if (state.isFilterAction) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          width: 180,
          child: TextFormField(
            initialValue: state.searchQuery,
            autofocus: true,
            key: ValueKey(state.selectedFilterOption),
            keyboardType: _getKeyboardType(state.selectedFilterOption),
            inputFormatters: _getInputFormatters(state.selectedFilterOption),
            decoration: InputDecoration(
              labelText: "Search by ${state.selectedFilterOption.label}",
              border: OutlineInputBorder(),
              suffixIcon:
                  state.searchQuery != null && state.searchQuery!.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      tooltip: 'Clear',
                      onPressed: cubit.clearSearch,
                    )
                  : null,
            ),

            onChanged: (text) => context
                .read<ManageUsersCubit>()
                .onSearchQueryChanged(text.trim()),
          ),
        );
      },
    );
  }
}
