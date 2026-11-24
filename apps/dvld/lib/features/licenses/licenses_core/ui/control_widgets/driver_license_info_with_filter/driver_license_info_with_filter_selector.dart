// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info/driver_license_info.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/logic/driver_license_info_with_filter_cubit/driver_license_info_with_filter_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/widgets/driver_license_info_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverLicenseInfoWithFilterSelector extends StatelessWidget {
  const DriverLicenseInfoWithFilterSelector({
    super.key,
    this.filterEnabled = true,
    this.onLicenseSelected,
  });

  final bool filterEnabled;
  final ValueChanged<int>? onLicenseSelected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      DriverLicenseInfoWithFilterCubit,
      DriverLicenseInfoWithFilterCubitState
    >(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is DriverLicenseInfoWithFilterCubitLoaded) {
          onLicenseSelected?.call(state.licenseId);
        }
      },
      builder: (context, state) {
        return Column(
          spacing: 20,
          children: [
            IgnorePointer(
              ignoring: !filterEnabled,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: filterEnabled ? 1 : 0.5,
                child: DriverLicenseInfoWithFilter(),
              ),
            ),
            switch (state) {
              DriverLicenseInfoWithFilterCubitLoaded(
                :final licenseInfoDetails,
              ) =>
                DriverLicenseInfo(licenseDetails: licenseInfoDetails),
              DriverLicenseInfoWithFilterCubitFailure(:final errorMessage) =>
                Center(child: Text(errorMessage)),
              DriverLicenseInfoWithFilterCubitLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              _ => SizedBox(
                width: double.infinity,
                height: 400,
                child: Center(child: Text('Search for a license ID First !')),
              ),
            },
          ],
        );
      },
    );
  }
}
