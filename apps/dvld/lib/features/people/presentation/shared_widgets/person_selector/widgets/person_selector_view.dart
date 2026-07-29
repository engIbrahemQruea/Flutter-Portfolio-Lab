import 'dart:developer';

import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/person_information_card.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/widgets/person_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonSelectorView extends StatelessWidget {
  const PersonSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PersonSelectorCubit, PersonSelectorCubitState>(
          buildWhen: (previous, current) =>
              previous.filterInputValue != current.filterInputValue,
          builder: (context, state) {
            log('1');
            return SizedBox(
              width: double.infinity,
              height: 100,
              child: PersonFilter(),
            );
          },
        ),
        verticalSpace(20),
        BlocBuilder<PersonSelectorCubit, PersonSelectorCubitState>(
          buildWhen: (previous, current) =>
              previous.personEntity != current.personEntity,
          builder: (context, state) {
            log('2');

            return PersonInformationCard(
              key: ValueKey(state.personEntity?.personId),
              person: state.personEntity,
              countryName: state.countryName,
            );
          },
        ),
      ],
    );
  }
}
