import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/next_button_widget.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/person_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonInfoTabWidget extends StatelessWidget {
  const PersonInfoTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isFilterEnabled = context.select(
      (AddUpdateLocalDrLiApplicationScreenCubit cubit) =>
          cubit.state.isEditMode,
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
                  context
                      .read<AddUpdateLocalDrLiApplicationScreenCubit>()
                      .onPersonSelected(personID: person.personId!);
                }
              },
            ),
            verticalSpace(5),
            NextButtonWidget(),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
