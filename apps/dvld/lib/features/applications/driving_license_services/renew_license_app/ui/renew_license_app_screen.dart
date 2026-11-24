import 'package:dvld/features/applications/driving_license_services/renew_license_app/ui/logic/renew_license_app_cubit/renew_license_app_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/ui/widgets/app_new_license_info.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/ui/widgets/save_close_button_renew_license_widget.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/driver_license_info_with_filter_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RenewLicenseAppScreen extends StatelessWidget {
  const RenewLicenseAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterEnable = context.select((RenewLicenseAppCubit cubit) {
      final state = cubit.state;
      if (state is RenewLicenseAppCubitSuccess) {
        return state.filterWidgetEnable;
      }
      return true;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Renew License Application'),
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
                    context.read<RenewLicenseAppCubit>().initRenewLicenseApp(
                      licenseId: value,
                    );
                  },
                ),
                AppNewLicenseInfo(),
                SaveCloseButtonRenewLicenseWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
