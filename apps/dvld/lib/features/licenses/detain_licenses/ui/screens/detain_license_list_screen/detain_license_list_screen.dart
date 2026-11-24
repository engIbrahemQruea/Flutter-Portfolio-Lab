import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_item_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_list_screen/logic/detained_licenses_list_cubit/detained_licenses_list_cubit.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_list_screen/widgets/detained_licenses_list_enums.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_list_screen/widgets/detained_list_filter_bar.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_list_screen/widgets/detained_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetainLicenseListScreen extends StatelessWidget {
  const DetainLicenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Detain License'),
        centerTitle: true,
      ),
      body: SafeArea(
        child:
            BlocBuilder<
              DetainedLicensesListCubit,
              DetainedLicensesListCubitState
            >(
              builder: (context, state) => switch (state) {
                DetainedLicensesListCubitLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                DetainedLicensesListCubitFailure(:final message) => Center(
                  child: Text(message),
                ),
                DetainedLicensesListCubitLoaded() => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: DetainedListFilterBar(
                        column: state.filterColumn,
                        textValue: state.textValue,
                        boolValue: state.boolValue,
                        onColumnChanged: (c) => context
                            .read<DetainedLicensesListCubit>()
                            .changeColumn(c),
                        onTextChanged: (v) => context
                            .read<DetainedLicensesListCubit>()
                            .changeTextValue(v),
                        onBoolChanged: (v) => context
                            .read<DetainedLicensesListCubit>()
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
                          Row(
                            children: [
                              FilledButton.icon(
                                onPressed: () async {
                                  final result = await context.pushNamed<bool>(
                                    DRoutes.detainLicenseScreen,
                                  );
                                  if (result != false || !context.mounted) {
                                    context
                                        .read<DetainedLicensesListCubit>()
                                        .refresh();
                                  }
                                },
                                icon: const Icon(Icons.lock_outline, size: 18),
                                label: const Text(' Detain License'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                onPressed: () async {
                                  final result = await context.pushNamed<bool>(
                                    DRoutes.releaseDetainedLicenseScreen,
                                  );
                                  if (result != false || !context.mounted) {
                                    context
                                        .read<DetainedLicensesListCubit>()
                                        .refresh();
                                  }
                                },

                                icon: const Icon(Icons.lock_open, size: 18),
                                label: const Text(' Release License'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state.filtered.isEmpty
                          ? const Center(
                              child: Text(' No records found for filter'),
                            )
                          : DetainedTable(
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
    DetainLicenseItemEntity entry,
    DetainedRowAction action,
  ) {
    switch (action) {
      case DetainedRowAction.personDetails:
        context.pushNamed(
          DRoutes.personDetailsScreen,
          queryParameters: {'personId': entry.personID.toString()},
        );
      case DetainedRowAction.licenseDetails:
        context.pushNamed(
          DRoutes.showLicenseInfoScreen,
          queryParameters: {
            'localDrLiApplicationId': 0.toString(),
            'licenseId': entry.licenseID.toString(),
          },
        );
      case DetainedRowAction.licenseHistory:
        context.pushNamed(
          DRoutes.showPersonLicenseHistoryScreen,
          queryParameters: {'personId': entry.personID.toString()},
        );
      case DetainedRowAction.release:
        context
            .pushNamed<bool>(
              DRoutes.releaseDetainedLicenseScreen,
              queryParameters: {'licenseId': entry.licenseID.toString()},
            )
            .then((value) {
              if (value != false || !context.mounted) {
                context.read<DetainedLicensesListCubit>().refresh();
              }
            });
    }
  }
}
