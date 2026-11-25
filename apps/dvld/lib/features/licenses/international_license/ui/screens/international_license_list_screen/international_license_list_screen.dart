import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/logic/international_license_list_cubit/international_license_list_cubit.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/widgets/international_license_list_enums.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/widgets/international_license_list_filter_bar.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/widgets/international_license_list_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternationalLicenseListScreen extends StatelessWidget {
  const InternationalLicenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('International License Applications'),
        centerTitle: true,
      ),
      body: SafeArea(
        child:
            BlocBuilder<
              InternationalLicenseListCubit,
              InternationalLicenseListCubitState
            >(
              builder: (context, state) => switch (state) {
                InternationalLicenseListCubitLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                InternationalLicenseListCubitFailure(:final message) => Center(
                  child: Text(message),
                ),
                InternationalLicenseListCubitLoaded() => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: InternationalLicenseListFilterBar(
                        column: state.filterColumn,
                        textValue: state.textValue,
                        boolValue: state.boolValue,
                        onColumnChanged: (c) => context
                            .read<InternationalLicenseListCubit>()
                            .changeColumn(c),
                        onTextChanged: (v) => context
                            .read<InternationalLicenseListCubit>()
                            .changeTextValue(v),
                        onBoolChanged: (v) => context
                            .read<InternationalLicenseListCubit>()
                            .changeBoolValue(v),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Records: ${state.recordsCount}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () async {
                              final result = await context.pushNamed<bool>(
                                DRoutes.newInternationalLicenseScreen,
                              );
                              if (result != false || !context.mounted) {
                                context
                                    .read<InternationalLicenseListCubit>()
                                    .refresh();
                              }
                            },

                            icon: const Icon(Icons.add, size: 18),
                            label: const Text(' Add International License'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state.filtered.isEmpty
                          ? const Center(
                              child: Text(' No records found for filter'),
                            )
                          : InternationalLicenseListTable(
                              entries: state.filtered,
                              onAction: (entry, action) =>
                                  _onRowAction(context, entry, action),
                            ),
                    ),
                  ],
                ),
                _ => const SizedBox.shrink(),
              },
            ),
      ),
    );
  }

  void _onRowAction(
    BuildContext context,
    InternationalLicenseEntity entry,
    InternationalLicenseRowAction action,
  ) {
    switch (action) {
      case InternationalLicenseRowAction.personDetails:
        AppDialogs.showWarning(context: context,
        title: 'Under Development',
        buttonText: 'OK',
         message: 'Under Development');
      // context.pushNamed(
      //   DRoutes.personDetailsScreen,
      //   queryParameters: {
      //     'personId': entry.internationalLicenseId.toString(),
      //   },
      // );
      case InternationalLicenseRowAction.licenseDetails:
        context.pushNamed(
          DRoutes.showLicenseInfoScreen,
          queryParameters: {
            'localDrLiApplicationId': 0.toString(),
            'licenseId': entry.issuedUsingLocalLicenseId.toString(),
          },
        );
      case InternationalLicenseRowAction.licenseHistory:
       AppDialogs.showWarning(context: context,
        title: 'Under Development',
        buttonText: 'OK',
         message: 'Under Development');
        // context.pushNamed(
        //   DRoutes.showPersonLicenseHistoryScreen,
        //   queryParameters: {
        //     'personId': entry.internationalLicenseId.toString(),
        //   },
        // );
    
    }
  }
}
