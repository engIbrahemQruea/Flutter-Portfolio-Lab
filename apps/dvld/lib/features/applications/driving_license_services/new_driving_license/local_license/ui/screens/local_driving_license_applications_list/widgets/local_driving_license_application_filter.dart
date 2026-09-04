import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/helper_list_local_dr_li_app/local_application_filter_type.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/logic/local_driving_license_applications_list_screen_cubit/local_driving_license_applications_list_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/widgets/local_driving_license_application_filter/search_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalDrivingLicenseApplicationFilter extends StatelessWidget {
  const LocalDrivingLicenseApplicationFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Text('Filter By: '),
        SizedBox(
          width: 200,
          child: DropdownMenuFormField<LocalApplicationFilterType>(
            initialSelection: LocalApplicationFilterType.none,
            dropdownMenuEntries: LocalApplicationFilterType.values
                .map(
                  (option) =>
                      DropdownMenuEntry(value: option, label: option.label),
                )
                .toList(),
            onSelected: (newOption) => context
                .read<LocalDrivingLicenseApplicationsListScreenCubit>()
                .onFilterTypeSelected(newOption!),
          ),
        ),
        SearchTextField(),
        const Spacer(),
        AppButton.icon(
          label: 'Add New',
          icon: IconButton.outlined(
            onPressed: () {},
            tooltip: 'Add New Local Driving License Application',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            mouseCursor: SystemMouseCursors.click,
            icon: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
