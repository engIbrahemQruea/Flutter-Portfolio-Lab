import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/new_international_license_screen/logic/new_international_license_cubit/new_international_license_cubit.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/new_international_license_screen/widgets/new_international_license_info.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/driver_license_info_with_filter_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewInternationalLicenseScreen extends StatelessWidget {
  const NewInternationalLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New International License'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child:
              BlocConsumer<
                NewInternationalLicenseCubit,
                NewInternationalLicenseCubitState
              >(
                listener: (context, state) {
                  if (state is NewInternationalLicenseCubitLoading) {
                    AppDialogs.showLoading(context: context);
                  }

                  if (state is NewInternationalLicenseCubitLoaded &&
                      state.message != null) {
                    AppDialogs.dismiss(context);
                    AppDialogs.showWarning(
                      context: context,
                      title: 'Warning',
                      buttonText: 'OK',
                      message: state.message ?? 'Something went wrong',
                    );
                  }

                  if (state is NewInternationalLicenseCubitLoaded &&
                      state.message == null) {
                    AppDialogs.dismiss(context);
                  }

                  if (state is NewInternationalLicenseCubitFailure) {
                    AppDialogs.dismiss(context);

                    AppDialogs.showFailure(
                      context: context,
                      title: 'Failure',
                      buttonText: 'OK',
                      message: state.message,
                    );
                  }
                  if (state is NewInternationalLicenseCubitSuccess) {
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
                      state is NewInternationalLicenseCubitSuccess;
                  final bool isProcessing =
                      state is NewInternationalLicenseCubitProcessing;
                  return PopScope(
                    canPop: !isProcessing,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DriverLicenseInfoWithFilterSelector(
                            filterEnabled: (!isSuccess && !isProcessing),
                            onLicenseSelected: (value) {
                              context
                                  .read<NewInternationalLicenseCubit>()
                                  .onSelectedLicenseID(licenseId: value);
                            },
                          ),
                          NewInternationalLicenseInfo(),
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
