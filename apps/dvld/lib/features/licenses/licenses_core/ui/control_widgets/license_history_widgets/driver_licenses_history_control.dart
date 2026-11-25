import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/license_history_widgets/ui/logic/driver_licenses_history_control_cubit/driver_licenses_history_control_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/license_history_widgets/ui/widgets/international_licenses_tab.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/license_history_widgets/ui/widgets/local_licenses_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverLicensesHistoryControl extends StatefulWidget {
  const DriverLicensesHistoryControl({super.key});

  @override
  State<DriverLicensesHistoryControl> createState() =>
      _DriverLicensesHistoryControlState();
}

class _DriverLicensesHistoryControlState
    extends State<DriverLicensesHistoryControl>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      DriverLicensesHistoryControlCubit,
      DriverLicensesHistoryControlCubitState
    >(
      builder: (context, state) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 5, bottom: 8),
                child: Text(
                  'License History',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: state is DriverLicensesHistoryControlCubitLoaded
                        ? 'Local Licenses (${state.localLicenseCount})'
                        : 'Local Licenses',
                  ),
                  Tab(
                    text: state is DriverLicensesHistoryControlCubitLoaded
                        ? 'International Licenses (${state.internationalLicenseCount})'
                        : 'International Licenses',
                  ),
                ],
              ),
              SizedBox(
                height: 350,
                child: switch (state) {
                  DriverLicensesHistoryControlCubitLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  DriverLicensesHistoryControlCubitFailure(
                    :final failureMessage,
                  ) =>
                    Center(child: Text(failureMessage)),
                  DriverLicensesHistoryControlCubitEmpty(:final message) =>
                    Center(child: Text(message)),
                  DriverLicensesHistoryControlCubitLoaded(
                    :final localLicenses,
                    :final internationalLicenses,
                  ) =>
                    TabBarView(
                      controller: _tabController,
                      children: [
                        LocalLicensesTab(
                          licenses: localLicenses,
                          onShowLicenseInfo: (licenseID) async {
                            await context.pushNamed<bool>(
                              DRoutes.showLicenseInfoScreen,
                              queryParameters: {
                                'localDrLiApplicationId': 0.toString(),
                                'licenseId': licenseID.toString(),
                              },
                            );
                          },
                        ),
                        InternationalLicensesTab(
                          licenses: internationalLicenses,
                          onShowInternationalInfo: (internationalLicenseId) {},
                        ),
                      ],
                    ),
                  _ => const Center(child: Text('Please wait Loading...')),
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
