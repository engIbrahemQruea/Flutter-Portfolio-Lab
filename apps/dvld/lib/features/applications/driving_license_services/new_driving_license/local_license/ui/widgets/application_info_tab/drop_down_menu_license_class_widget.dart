import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownMenuLicenseClassWidget extends StatelessWidget {
  const DropdownMenuLicenseClassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      AddUpdateLocalDrLiApplicationScreenCubit,
      AddUpdateLocalDrLiApplicationScreenCubitState
    >(
      builder: (context, state) {
        if (state.licenseClassStatus.isLoading) {
          return Center(child: const CircularProgressIndicator());
        }
        if (state.licenseClassStatus.isFailure) {
          AppDialogs.dismiss(context);
          AppDialogs.showFailure(
            context: context,
            title: 'Error',
            buttonText: 'Tray Again',
            message: '${state.errorMessageLicenseClass}',
          );
        }
        if (state.licenseClassStatus.isSuccess &&
            state.licenseClasses.isEmpty) {
          AppDialogs.dismiss(context);
          AppDialogs.showFailure(
            context: context,
            title: 'Error',
            buttonText: 'Tray Again',
            message: '${state.errorMessageLicenseClass}',
          );
        }
        if (state.licenseClassStatus.isSuccess) {
          return DropdownMenuFormField(
            label: Text('License Class'),
            hintText: 'Select License Class',
            width: 300,
            initialSelection: state.selectedLicenseClassId,
            dropdownMenuEntries: state.licenseClasses
                .map(
                  (e) => DropdownMenuEntry(
                    label: e.className,
                    value: e.licenseClassId,
                  ),
                )
                .toList(),

            onSelected: (value) => value != null
                ? context
                      .read<AddUpdateLocalDrLiApplicationScreenCubit>()
                      .onSelectedLicenseClassId(valueIndex: value)
                : null,
          );
        }
        return const Center(child: Text('No Data Loaded'));
      },
    );
  }
}
