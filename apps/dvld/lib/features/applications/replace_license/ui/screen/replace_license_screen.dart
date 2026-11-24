import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/applications/replace_license/ui/logic/replace_license_screen_cubit/replace_license_cubit.dart';
import 'package:dvld/features/applications/replace_license/ui/screen/widgets/replace_license_info.dart';
import 'package:dvld/features/applications/replace_license/ui/screen/widgets/replacement_type_selector.dart';
import 'package:dvld/features/applications/replace_license/ui/screen/widgets/save_close_button_renew_license_widget.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/driver_license_info_with_filter_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplaceLicenseScreen extends StatelessWidget {
  const ReplaceLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterEnable = context.select((ReplaceLicenseCubit cubit) {
      final state = cubit.state;
      if (state is ReplaceLicenseCubitSuccess) {
        return state.filterWidgetEnable;
      }
      return true;
    });

    final currentState = context.watch<ReplaceLicenseCubit>().state;
    final cubit = context.read<ReplaceLicenseCubit>();

    IssueReason? selectedReason;
    if (currentState is ReplaceLicenseCubitLoaded) {
      selectedReason = currentState.selectedReason;
    } else if (currentState is ReplaceLicenseCubitNotLoaded) {
      selectedReason = currentState.selectedReason;
    }

    final onChanged = cubit.changeReason;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Replace For Damaged License'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              spacing: 10,
              children: [
                DriverLicenseInfoWithFilterSelector(
                  filterEnabled: filterEnable,
                  onLicenseSelected: (value) {
                    cubit.initReplaceLicense(oldLicenseId: value);
                  },
                ),

                if (currentState is ReplaceLicenseCubitLoaded &&
                    selectedReason != null)
                  ReplacementTypeSelector(
                    selected: selectedReason,
                    onChanged: onChanged,
                  ),
                verticalSpace(5),
                const ReplaceLicenseInfo(),
                const SaveCloseButtonReplaceLicenseWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
