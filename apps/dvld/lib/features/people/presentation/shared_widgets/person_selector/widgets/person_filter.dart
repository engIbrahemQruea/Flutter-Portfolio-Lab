import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/widgets/add_person_button.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/widgets/filter_input.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/widgets/search_button.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/widgets/selected_filter.dart';
import 'package:flutter/material.dart';

class PersonFilter extends StatelessWidget {
  const PersonFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const .symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            Text('Find By :', style: Theme.of(context).textTheme.titleMedium),
            horizontalSpace(10),
            SelectedFilterDropdownButton(),
            horizontalSpace(10),
            FilterInput(),
            horizontalSpace(10),
            SearchButton(),
            horizontalSpace(10),
            AddPersonButton(),
          ],
        ),
      ),
    );
  }
}
