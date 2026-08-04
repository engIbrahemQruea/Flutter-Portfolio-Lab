// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/person_information_card.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/widgets/person_filter.dart';

class PersonSelector extends StatelessWidget {
  const PersonSelector({
    super.key,
     this.isFilterEnabled=false,
    this.onPersonSelected,
  });

  final bool isFilterEnabled;
  final ValueChanged<PeopleEntity?>? onPersonSelected;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonSelectorCubit, PersonSelectorCubitState>(
      listenWhen: (previous, current) =>
          previous.personEntity != current.personEntity,
      listener: (context, state) {
        onPersonSelected?.call(state.personEntity);
      },
      child: Column(
        children: [
          BlocBuilder<PersonSelectorCubit, PersonSelectorCubitState>(
            buildWhen: (previous, current) =>
                previous.filterInputValue != current.filterInputValue,
            builder: (context, state) {
              log('1');
              return IgnorePointer(
                ignoring: isFilterEnabled!,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isFilterEnabled! ? 0.5 : 1,
                  child: SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: PersonFilter(),
                  ),
                ),
              );
            },
          ),
          verticalSpace(10),
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
      ),
    );
  }
}
