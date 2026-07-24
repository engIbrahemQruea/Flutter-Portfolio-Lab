
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton.custom(
      label: 'Search',
      icon: const Icon(Icons.search),
      onPressed: ()=>context.read<PersonSelectorCubit>().onSearch(),
    );
  }
}