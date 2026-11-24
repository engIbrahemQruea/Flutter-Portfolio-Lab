import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/helper_list_local_dr_li_app/local_application_filter_type.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/logic/local_driving_license_applications_list_screen_cubit/local_driving_license_applications_list_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      LocalDrivingLicenseApplicationsListScreenCubit,
      LocalDrivingLicenseApplicationsListScreenCubitState
    >(
      buildWhen: (previous, current) =>
          previous.hasNoFiltered != current.hasNoFiltered ||
          previous.localAppFilterType != current.localAppFilterType,
      builder: (context, state) {
        final filterAppType = state.localAppFilterType;
        return SizedBox(
          width: 250,
          child: TextField(
            // focusNode: focusNode,
            canRequestFocus: !state.hasNoFiltered,
            showCursor: !state.hasNoFiltered,
            enabled: !state.hasNoFiltered,
            mouseCursor: SystemMouseCursors.click,
            keyboardType: filterAppType.keyboardType,
            inputFormatters: filterAppType.inputFormatters,
            onChanged: (value) => context
                .read<LocalDrivingLicenseApplicationsListScreenCubit>()
                .onFilterValueChanged(value),
            decoration: InputDecoration(
              label: Text('Search by ${state.localAppFilterType.label}'),
              suffix: Icon(Icons.clear),
              hint: Text('Search...'),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}
