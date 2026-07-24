import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/widgets/person_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonSelectorView extends StatelessWidget {
  const PersonSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonSelectorCubit, PersonSelectorCubitState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 100,
              child: PersonFilter(),
            ),
          ],
        );
      },
    );
  }
}
