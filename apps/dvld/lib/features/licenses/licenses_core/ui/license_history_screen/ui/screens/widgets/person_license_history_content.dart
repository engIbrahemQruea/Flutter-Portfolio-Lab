// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/license_history_widgets/driver_licenses_history_control.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/license_history_widgets/ui/logic/driver_licenses_history_control_cubit/driver_licenses_history_control_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/license_history_screen/ui/logic/cubit/person_license_history_screen_cubit.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/person_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonLicenseHistoryContent extends StatefulWidget {
  const PersonLicenseHistoryContent({super.key, required this.personID});

  final int? personID;

  @override
  State<PersonLicenseHistoryContent> createState() =>
      _PersonLicenseHistoryContentState();
}

class _PersonLicenseHistoryContentState
    extends State<PersonLicenseHistoryContent> {
  @override
  void initState() {
    super.initState();
    if (widget.personID != null) {
      context.read<PersonSelectorCubit>().loadInfoPersonByPersonID(
        personID: widget.personID,
      );
      context.read<DriverLicensesHistoryControlCubit>().loadInfoByPersonId(
        personId: widget.personID!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFilterEnabled = widget.personID != null;
    return BlocListener<
      PersonLicenseHistoryScreenCubit,
      PersonLicenseHistoryScreenCubitState
    >(
      listener: (context, state) {
        switch (state) {
          case PersonNoSelectedLicenseHistoryScreenCubit():
            context.read<DriverLicensesHistoryControlCubit>().clearState();
            break;
          case PersonSelectedLicenseHistoryScreenCubit(:final personId):
            context
                .read<DriverLicensesHistoryControlCubit>()
                .loadInfoByPersonId(personId: personId);
            break;
          default:
            break;
        }
      },
      child: Column(
        spacing: 15,
        children: [
          PersonSelector(
            isFilterEnabled: isFilterEnabled,
            onPersonSelected: (value) {
              if (value != null) {
                context
                    .read<PersonLicenseHistoryScreenCubit>()
                    .onPersonSelected(value.personId!);
              }
            },
          ),
          DriverLicensesHistoryControl(),
        ],
      ),
    );
  }
}
