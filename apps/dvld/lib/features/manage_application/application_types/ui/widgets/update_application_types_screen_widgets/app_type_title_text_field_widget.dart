// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/manage_application/application_types/ui/logic/update_application_types_screen_cubit/update_application_types_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTypeTitleTextFieldWidget extends StatelessWidget {
  const AppTypeTitleTextFieldWidget({
    super.key,
    required this.appTypeTitleController,
  });

  final TextEditingController appTypeTitleController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      UpdateApplicationTypesScreenCubit,
      UpdateApplicationTypesScreenCubitState
    >(
      builder: (context, state) {
        return SizedBox(
          width: 250,
          child: AppTextField(
            controller: appTypeTitleController,
            label: 'Application Type Title',
            hintText: 'Enter Application Type Title Here...',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            maxLines: 2,
            autoFocus: true,
            prefixIcon: Icons.apps_outlined,
            isValid: state.applicationTypeTitle.isValid,
            validator: (value) => state.applicationTypeTitle.isValid
                ? null
                : state.applicationTypeTitle.error,
            onChanged: (value) => context
                .read<UpdateApplicationTypesScreenCubit>()
                .onChangeApplicationTypeTitle(appTitle: value),
          ),
        );
      },
    );
  }
}
