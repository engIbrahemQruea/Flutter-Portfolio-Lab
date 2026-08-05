import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/manage_users/presentation/logic/user_information_card_cubit/user_information_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocBuilderRowLoginInfoWidget extends StatelessWidget {
  const BlocBuilderRowLoginInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInformationCardCubit, UserInformationCardCubitState>(
      buildWhen: (previous, current) =>
          previous.userEntity != current.userEntity,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User ID : ${state.userEntity?.userID ?? '???'}'),
            horizontalSpace(30),
            Text('User Name : ${state.userEntity?.userName ?? '???'}'),
            horizontalSpace(30),
            Text('is Active : ${state.userEntity?.isActive ?? '???'}'),
          ],
        );
      },
    );
  }
}
