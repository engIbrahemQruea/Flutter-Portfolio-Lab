import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/widgets/save_close_button.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/widgets/tab_bar_and_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateUsersScreen extends StatelessWidget {
  const AddUpdateUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isEditMode = context.select(
      (AddUpdateUserFormCubit cubit) => cubit.state.isEditMode,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Update User Screen' : 'Add User Screen'),
        centerTitle: true,
        elevation: 10,
      ),
      body: Column(
        children: [
          Expanded(child: TabBarAndTabBarView()),
          verticalSpace(10),
          SaveCloseButton(),
          verticalSpace(10),
        ],
      ),
    );
  }
}
