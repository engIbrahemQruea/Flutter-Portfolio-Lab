import 'package:dvld/core/helpers/extensions_x/enum_users_filter_option_x.dart';
import 'package:dvld/features/manage_users/presentation/logic/cubit/manage_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageUsersCubit>();

    return BlocBuilder<ManageUsersCubit, ManageUsersCubitState>(
      buildWhen: (previous, current) =>
          previous.searchQuery != current.searchQuery ||
          previous.selectedFilterOption != current.selectedFilterOption,
      builder: (context, state) {
        if (state.hasNoFilter) {
          return const SizedBox.shrink();
        }

        final filter = state.selectedFilterOption;
        final hasQuery =
            state.searchQuery != null && state.searchQuery!.isNotEmpty;

        return SizedBox(
          width: 180,
          child: TextFormField(
            key: ValueKey('${filter.name}_${state.searchQuery ?? ''}'),
            initialValue: state.searchQuery,
            autofocus: true,
            keyboardType: filter.keyboardType,
            inputFormatters: filter.inputFormatters,
            decoration: InputDecoration(
              labelText: "Search by ${filter.label}",
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              suffixIcon: hasQuery
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      tooltip: 'Clear',
                      onPressed: cubit.clearSearch,
                    )
                  : null,
            ),
            onChanged: (text) => cubit.onSearchQueryChanged(text.trim()),
          ),
        );
      },
    );
  }
}
