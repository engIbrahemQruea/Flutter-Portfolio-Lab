import 'dart:developer';

import 'package:dvld/core/helpers/forms/enums.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/helpers/add_update_user_screen_controllers.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/widgets/login_info_tab.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/widgets/person_info_tab.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarAndTabBarView extends StatefulWidget {
  const TabBarAndTabBarView({super.key});

  @override
  State<TabBarAndTabBarView> createState() => _TabBarAndTabBarViewState();
}

class _TabBarAndTabBarViewState extends State<TabBarAndTabBarView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AddUpdateUserScreenControllers _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = AddUpdateUserScreenControllers();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<AddUpdateUserFormCubit>().onChangeTabIndex(
          _tabController.index,
        );
      }
    });
  }

  void initControllers(AddUpdateUserFormCubitState state) {
    _controllers.userIdController.text = state.userId?.toString() ?? '';
    _controllers.userNameController.text = state.userName.value ?? '';
    _controllers.passwordController.text = state.password.value ?? '';
    _controllers.confirmPasswordController.text =
        state.confirmPassword.value ?? '';
  }

  @override
  void dispose() {
    _tabController.dispose();
    log(_controllers.toString());
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUpdateUserFormCubit, AddUpdateUserFormCubitState>(
      listenWhen: (previous, current) =>
          previous.selectedTabIndex != current.selectedTabIndex ||
          current.loadUserStatus == RequestStatus.success ||
          (previous.saveButtonStatus != current.saveButtonStatus &&
              current.saveButtonStatus.isSuccess),
      listener: (context, state) {
        _tabController.animateTo(state.selectedTabIndex);
        if (state.loadUserStatus == RequestStatus.success ||
            state.saveButtonStatus.isSuccess) {
          initControllers(state);
        }

        if (state.loadUserStatus == RequestStatus.success) {
          context.read<PersonSelectorCubit>().loadInfoPersonByPersonID(
            personID: state.personId,
          );
        }
      },

      child: BlocBuilder<AddUpdateUserFormCubit, AddUpdateUserFormCubitState>(
        buildWhen: (previous, current) =>
            previous.loadUserStatus != current.loadUserStatus,
        builder: (context, state) {
          if (state.loadUserStatus == RequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.loadUserStatus == RequestStatus.failure) {
            return const Center(child: Text('Failed to load user data'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 400,
                child: TabBar(
                  labelColor: Colors.blue,
                  controller: _tabController,
                  unselectedLabelColor: Colors.grey,
                  mouseCursor: WidgetStateMouseCursor.clickable,
                  tabs: const [
                    Tab(text: 'Person Information'),
                    Tab(text: 'Login Information'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const PersonInfoTab(),
                    LoginInfoTab(controllers: _controllers),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
