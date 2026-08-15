// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/manage_application/application_types/ui/logic/update_application_types_screen_cubit/update_application_types_screen_cubit.dart';

class AppTypeFeeTextFieldWidget extends StatelessWidget {
  const AppTypeFeeTextFieldWidget({
    super.key,
    required this.appTypeFeeController,
  });

  final TextEditingController appTypeFeeController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      UpdateApplicationTypesScreenCubit,
      UpdateApplicationTypesScreenCubitState
    >(
      buildWhen: (previous, current) =>
          previous.applicationTypeFee != current.applicationTypeFee,
      builder: (context, state) {
        return SizedBox(
          width: 250,
          child: AppTextField(
            //initialValue: state.applicationTypeFee.value.toString(),
            controller: appTypeFeeController,
            label: 'Application Type Fee',
            hintText: 'Enter Application Type Fee Here...',
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            prefixIcon: Icons.price_change_outlined,
            isValid: state.applicationTypeFee.isValid,
            validator: (value) => state.applicationTypeFee.isValid
                ? null
                : state.applicationTypeFee.error,
            onChanged: (value) => context
                .read<UpdateApplicationTypesScreenCubit>()
                .onChangeApplicationTypeFee(appFee: value),
          ),
        );
      },
    );
  }
}
