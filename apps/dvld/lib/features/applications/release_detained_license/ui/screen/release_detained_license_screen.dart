// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/features/applications/release_detained_license/ui/logic/release_detained_license_cubit/release_detained_license_cubit.dart';
import 'package:dvld/features/applications/release_detained_license/ui/screen/widgets/release_detained_license_info.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/driver_license_info_with_filter_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReleaseDetainedLicenseScreen extends StatelessWidget {
  const ReleaseDetainedLicenseScreen({super.key, this.licenseId});

  final int? licenseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Release Detained License'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child:
              BlocConsumer<
                ReleaseDetainedLicenseCubit,
                ReleaseDetainedLicenseCubitState
              >(
                listener: (context, state) {
                  if (state is ReleaseDetainedLicenseCubitLoading) {
                    AppDialogs.showLoading(context: context);
                  }

                  if (state is ReleaseDetainedLicenseCubitLoaded &&
                      state.errorMessage != null) {
                    AppDialogs.dismiss(context);
                    AppDialogs.showWarning(
                      context: context,
                      title: 'Warning',
                      buttonText: 'OK',
                      message: state.errorMessage.toString(),
                    );
                  }

                  if (state is ReleaseDetainedLicenseCubitLoaded &&
                      state.errorMessage == null) {
                    AppDialogs.dismiss(context);
                  }

                  if (state is ReleaseDetainedLicenseCubitFailure) {
                    AppDialogs.showFailure(
                      context: context,
                      title: 'Error',
                      buttonText: 'OK',
                      message: state.message.toString(),
                    );
                  }
                  if (state is ReleaseDetainedLicenseCubitSuccess) {
                    AppDialogs.showSuccess(
                      context: context,
                      title: 'Success',
                      buttonText: 'OK',
                      message: 'License released successfully',
                    );
                  }
                },
                builder: (context, state) {
                  final bool isSuccess =
                      state is ReleaseDetainedLicenseCubitSuccess;
                  final bool isProcessing =
                      state is ReleaseDetainedLicenseCubitProcessing;
                  return PopScope(
                    canPop: !isProcessing,
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 12,
                        children: [
                          DriverLicenseInfoWithFilterSelector(
                            filterEnabled:
                                (!isSuccess &&
                                !isProcessing &&
                                licenseId == null),
                            onLicenseSelected: (value) {
                              //onLicenseSelected
                              context
                                  .read<ReleaseDetainedLicenseCubit>()
                                  .getReleaseDetails(value);
                            },
                          ),
                          ReleaseDetainedLicenseInfo(),
                        ],
                      ),
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }
}
