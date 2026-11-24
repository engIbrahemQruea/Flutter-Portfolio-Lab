import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_screen/logic/detain_license_cubit/detain_license_cubit.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_screen/widgets/detain_license_info.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/driver_license_info_with_filter_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetainLicenseScreen extends StatelessWidget {
  const DetainLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detain License'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: BlocConsumer<DetainLicenseCubit, DetainLicenseCubitState>(
            listener: (context, state) {
              if (state is DetainLicenseCubitLoaded &&
                  state.errorMessage != null) {
                AppDialogs.showWarning(
                  context: context,
                  title: 'Error',
                  buttonText: 'OK',
                  message: state.errorMessage.toString(),
                );
              }
              if (state is DetainLicenseCubitSuccess) {
                AppDialogs.showSuccess(
                  context: context,
                  title: 'Success',
                  buttonText: 'OK',
                  message: 'License detained successfully',
                );
              }
              if (state is DetainLicenseCubitFailure) {
                AppDialogs.showFailure(
                  context: context,
                  title: 'Error',
                  buttonText: 'OK',
                  message: state.errorMessage.toString(),
                );
              }
            },
            builder: (context, state) {
              final isProcessing = state is DetainLicenseCubitProcessing;
              final isSuccess = state is DetainLicenseCubitSuccess;
              return PopScope(
                canPop: !isProcessing,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 12,
                    children: [
                      DriverLicenseInfoWithFilterSelector(
                        filterEnabled: (!isSuccess && !isProcessing),
                        onLicenseSelected: (value) {
                          context.read<DetainLicenseCubit>().onLicenseSelected(
                            licenseId: value,
                          );
                        },
                      ),
                      DetainLicenseInfo(),
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
