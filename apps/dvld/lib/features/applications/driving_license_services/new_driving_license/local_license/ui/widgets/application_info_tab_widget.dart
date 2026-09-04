// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/helepers/add_update_local_driving_license_application_screen_controllers.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/application_info_tab/application_date_text_form_field_widget.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/application_info_tab/application_fees_text_form_field_widget.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/application_info_tab/created_by_text_form_field_widget.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/application_info_tab/drop_down_menu_license_class_widget.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/application_info_tab/local_d_l_applicaions_id_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationInfoTabWidget extends StatelessWidget {
  const ApplicationInfoTabWidget({super.key, required this.controllers});

  final AddUpdateLocalDrivingLicenseApplicationScreenControllers controllers;

  @override
  Widget build(BuildContext context) {
    final isAppInfoEnabled = context.select(
      (AddUpdateLocalDrLiApplicationScreenCubit cubit) =>
          cubit.state.isApplicationInfoEnabled,
    );
    return IgnorePointer(
      ignoring: isAppInfoEnabled,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isAppInfoEnabled ? 0.5 : 1.0,
        child: Padding(
          padding: const .symmetric(vertical: 20),
          child: Column(
            spacing: 20,
            children: [
              LocalDLApplicationIDTextForm(controllers: controllers),
              ApplicationDateTextFieldWidget(
                appDateController: controllers.applicationDateController,
              ),

              DropdownMenuLicenseClassWidget(),

              ApplicationFeesTextFieldWidget(
                appFeesController: controllers.applicationFeesController,
              ),
              CreatedByTextFieldWidget(
                createdByController: controllers.createdByUserIdController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
