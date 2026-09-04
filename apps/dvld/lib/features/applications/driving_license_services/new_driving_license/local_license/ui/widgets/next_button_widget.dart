import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: AppButton.custom(
        icon: const Icon(Icons.arrow_circle_right, size: 24),
        label: 'Next',
        onPressed: () => context
            .read<AddUpdateLocalDrLiApplicationScreenCubit>()
            .onPressNextButton(),
      ),
    );
  }
}
