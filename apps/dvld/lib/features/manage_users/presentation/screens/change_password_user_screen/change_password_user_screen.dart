import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/manage_users/presentation/logic/change_password_user_screen_cubit/cubit/change_password_user_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/change_password_user_screen/widgets/change_password_form_field_widget.dart';
import 'package:dvld/features/manage_users/presentation/screens/change_password_user_screen/widgets/save_close_row_button_widget.dart';
import 'package:dvld/features/manage_users/presentation/screens/shared_user_widgets/user_information_card_widget/user_information_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordUserScreen extends StatelessWidget {
  const ChangePasswordUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserInformationCardWidget(
              onUserSelected: (user) {
                if (user != null) {
                  context.read<ChangePasswordUserCubit>().onUserSelected(
                    user: user,
                  );
                }
              },
            ),
            verticalSpace(15),
            ChangePasswordFormFieldWidget(),
            verticalSpace(20),
            SaveCloseRowButtonWidget(),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
