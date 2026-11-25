import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/licenses/international_license/ui/control_widgets_international_license/driver_international_license_info/driver_international_license_info.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/show_international_license_info_screen/logic/cubit/show_international_license_info_cubit.dart';
import 'package:dvld/features/login/presentation/screens/widgets/login_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowInternationalLicenseInfoScreen extends StatelessWidget {
  const ShowInternationalLicenseInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('International License Application Info'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 10,
            children: [
              BlocBuilder<
                ShowInternationalLicenseInfoCubit,
                ShowInternationalLicenseInfoCubitState
              >(
                builder: (context, state) {
                  switch (state) {
                    case ShowInternationalLicenseInfoCubitLoading():
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    case ShowInternationalLicenseInfoCubitLoaded():
                      return DriverInternationalLicenseInfo(
                        internationalLicenseDetails:
                            state.internationalLicenseDetailsReadEntity,
                      );
                    case ShowInternationalLicenseInfoCubitFailure(
                      :final message,
                    ):
                      return Center(child: Text(message));
                    default:
                      break;
                  }
                  return Container();
                },
              ),
              AppButton.icon(
                onPressed: () {
                  context.pop();
                },
                label: 'Close',
                icon: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
