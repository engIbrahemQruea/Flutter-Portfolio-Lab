import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/save_close_button_local_d_l_app_widget.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/tab_bar_and_tab_bar_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateLocalDrivingLicenseApplicationScreen extends StatelessWidget {
  const AddUpdateLocalDrivingLicenseApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AddUpdateLocalDLAppTitleAppBar(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: TabBarAndTabBarViewWidget()),
          verticalSpace(10),
          const SaveCloseButtonLocalDLAppWidget(),
          verticalSpace(10),
        ],
      ),
    );
  }
}

class AddUpdateLocalDLAppTitleAppBar extends StatelessWidget {
  const AddUpdateLocalDLAppTitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isEditMode = context.select(
      (AddUpdateLocalDrLiApplicationScreenCubit cubit) =>
          cubit.state.isEditMode,
    );
    return Text(
      isEditMode
          ? 'Update Local Driving License Application'
          : 'Add Local Driving License Application',
    );
  }
}
