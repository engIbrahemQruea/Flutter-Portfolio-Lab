// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedByTextFieldWidget extends StatelessWidget {
  const CreatedByTextFieldWidget({
    super.key,
    required this.createdByController,
  });

  final TextEditingController createdByController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      AddUpdateLocalDrLiApplicationScreenCubit,
      AddUpdateLocalDrLiApplicationScreenCubitState
    >(
      buildWhen: (previous, current) =>
          previous.createdByUser != current.createdByUser ||
          previous.userEntity != current.userEntity,
      builder: (context, state) {
        return SizedBox(
          width: 300,
          child: AppTextField(
            label: 'Created By User',
            hintText: '',
            isReadOnly: true,
            prefixIcon: Icons.person,
            controller: createdByController,
          ),
        );
      },
    );
  }
}
