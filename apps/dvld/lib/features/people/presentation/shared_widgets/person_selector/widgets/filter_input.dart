import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterInput extends StatelessWidget {
  const FilterInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search',
          suffixIcon: const Icon(Icons.search),
        ),
        onChanged: (value) =>
            context.read<PersonSelectorCubit>().onChangedFilterValue(value.trim()),
      ),
    );
  }
}
