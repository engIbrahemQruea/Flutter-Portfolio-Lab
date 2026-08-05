import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/manage_users/presentation/screens/shared_user_widgets/user_information_card_widget/widgets/bloc_builder_row_login_info_widget.dart';
import 'package:flutter/material.dart';

class LoginInformationUserWidget extends StatelessWidget {
  const LoginInformationUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        verticalSpace(5),
        Card.outlined(
          child: Padding(
            padding: const .symmetric(vertical: 20),
            child: BlocBuilderRowLoginInfoWidget(),
          ),
        ),
      ],
    );
  }
}
