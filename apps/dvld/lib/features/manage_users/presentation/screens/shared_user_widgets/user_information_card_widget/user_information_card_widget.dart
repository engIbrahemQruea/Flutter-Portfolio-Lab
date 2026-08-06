// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/forms/forms.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/manage_users/presentation/logic/user_information_card_cubit/user_information_card_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/shared_user_widgets/user_information_card_widget/widgets/login_information_user_widget.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/person_information_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserInformationCardWidget extends StatelessWidget {
  const UserInformationCardWidget({super.key, this.onUserSelected});

  final ValueChanged<UserEntity?>? onUserSelected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      UserInformationCardCubit,
      UserInformationCardCubitState
    >(
      listenWhen: (previous, current) =>
          previous.userInformationCardStatus !=
              current.userInformationCardStatus ||
          previous.peopleEntity != current.peopleEntity ||
          previous.userEntity != current.userEntity,
      listener: (context, state) {
        onUserSelected?.call(state.userEntity);
        switch (state.userInformationCardStatus) {
          case RequestStatus.loading:
            AppDialogs.showLoading(context: context);
            break;

          case RequestStatus.success:
            // context.pop();
            break;

          case RequestStatus.failure:
            context.pop();
            AppDialogs.showFailure(
              context: context,
              title: 'Error Loading User',
              buttonText: 'OK',
              message: state.errorMessage ?? 'Something went wrong',
            );
            break;

          case RequestStatus.initial:
            break;
        }
      },

      buildWhen: (previous, current) =>
          previous.userInformationCardStatus !=
              current.userInformationCardStatus ||
          previous.peopleEntity != current.peopleEntity ||
          previous.countryName != current.countryName,

      builder: (context, state) {
        return switch (state.userInformationCardStatus) {
          RequestStatus.success => Column(
            children: [
              verticalSpace(5),
              PersonInformationCard(
                person: state.peopleEntity,
                countryName: state.countryName,
                onEdit: (personId) async {
                  final result = await context.pushNamed<bool>(
                    DRoutes.addUpdatePeopleScreen,
                    queryParameters: {'personId': personId.toString()},
                  );
                  if (result == true && context.mounted) {
                    await context
                        .read<UserInformationCardCubit>()
                        .refreshPersonInfo(personID: personId);
                  }
                },
              ),
              verticalSpace(20),
              const LoginInformationUserWidget(),
            ],
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
