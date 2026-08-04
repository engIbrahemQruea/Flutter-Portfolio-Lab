// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/widgets/next_button.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/person_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonInfoTab extends StatelessWidget {
  const PersonInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isFilterEnabled = context.select(
      (AddUpdateUserFormCubit cubit) => cubit.state.isEditMode,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const .symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: .end,
          children: [
            PersonSelector(
              isFilterEnabled: isFilterEnabled,
              onPersonSelected: (person) {
                if (person != null && person.personId != null) {
                  context.read<AddUpdateUserFormCubit>().onPersonSelected(
                    personID: person.personId!,
                  );
                }
              },
            ),
            verticalSpace(5),
            NextButton(),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
