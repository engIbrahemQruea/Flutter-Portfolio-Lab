import 'package:dvld/features/licenses/licenses_core/ui/show_license_info_screen/logic/show_license_info_cubit/show_license_info_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info/driver_license_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocBuilderDriverLicenseInfo extends StatelessWidget {
  const BlocBuilderDriverLicenseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowLicenseInfoCubit, ShowLicenseInfoCubitState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is ShowLicenseInfoCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ShowLicenseInfoCubitFailure) {
          return Center(child: Text(state.message));
        }
        if (state is ShowLicenseInfoCubitLoaded) {
          return DriverLicenseInfo(licenseDetails: state.licenseDetailsEntity);
        }
        return Container();
      },
    );
  }
}
