import 'dart:developer';

import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PersonSelectorCubit>();
    return BlocListener<PersonSelectorCubit, PersonSelectorCubitState>(
      listenWhen: (previous, current) =>
          previous.searchStatus != current.searchStatus,
      listener: (context, state) {
        if (state.searchStatus == EnRequestStatus.failure) {
          AppDialogs.showFailure(
            context: context,
            message: state.errorMessage!,
          );
        }
      },
      child: AppButton.custom(
        label: 'Search',
        icon: const Icon(Icons.search),
        onPressed: cubit.state.filterInputValue == null
            ? null
            : () {
                cubit.onPressedSearchButton();
                log('onPressedSearchButton');
              },
      ),
    );
  }
}
