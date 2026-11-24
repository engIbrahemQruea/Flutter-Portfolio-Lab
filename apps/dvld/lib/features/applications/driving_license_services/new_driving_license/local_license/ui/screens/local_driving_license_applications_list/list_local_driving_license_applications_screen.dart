import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/helper_list_local_dr_li_app/list_local_d_l_app_data_source.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/logic/local_driving_license_applications_list_screen_cubit/local_driving_license_applications_list_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/widgets/local_driving_license_application_context_menu/local_d_l_application_show_context_menu.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/widgets/local_driving_license_application_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ListLocalDrivingLicenseApplicationsScreen extends StatelessWidget {
  const ListLocalDrivingLicenseApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Driving License Applications '),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const .symmetric(horizontal: 10, vertical: 10),
          child: Column(
            spacing: 10,
            children: [
              const LocalDrivingLicenseApplicationFilter(),
              BlocBuilder<
                LocalDrivingLicenseApplicationsListScreenCubit,
                LocalDrivingLicenseApplicationsListScreenCubitState
              >(
                buildWhen: (previous, current) =>
                    previous.loadLocalAppStatus.isSuccess ||
                    current.loadLocalAppStatus.isSuccess ||
                    current.applicationsList != previous.applicationsList ||
                    current.filteredApplicationsList !=
                        previous.filteredApplicationsList,

                builder: (context, state) {
                  if (state.loadLocalAppStatus.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.loadLocalAppStatus.isFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage ?? 'Something went wrong',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  final isFiltering = !state.hasNoFiltered;
                  final lDLAppList = isFiltering
                      ? state.filteredApplicationsList
                      : state.applicationsList;

                  if (lDLAppList.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 20,
                      ),
                      child: Center(
                        child: Text(
                          'No Local Driving License Applications Found For this ${state.filterValue} 😔',
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  }

                  return SfDataGrid(
                    source: ListLocalDLAppDataSource(
                      localDLAppList: lDLAppList,
                    ),
                    selectionMode: SelectionMode.single,
                    allowSorting: true,
                    allowFiltering: true,
                    showColumnHeaderIconOnHover: true,
                    columnWidthMode: ColumnWidthMode.auto,
                    columnWidthCalculationRange:
                        ColumnWidthCalculationRange.allRows,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    footer: Center(
                      child: Text(
                        'Total Records: ${state.applicationsList.length}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    onCellSecondaryTap: (details) async {
                      final rowIndex = details.rowColumnIndex.rowIndex;
                      if (rowIndex <= 0 || rowIndex > lDLAppList.length) return;

                      final selectedApp = lDLAppList[rowIndex - 1];
                      final selectedLDLAppId = selectedApp.localDrLiAppViewId;

                      final cubit = context
                          .read<
                            LocalDrivingLicenseApplicationsListScreenCubit
                          >();

                      await cubit.getLocalApplicationMenuPermissions(
                        localDLAppItemEntity: selectedApp,
                      );

                      if (!context.mounted) return;

                      final permissions = cubit.state.permissionsMenu;
                      if (permissions == null) return;

                      final selectedAction = await context
                          .showLocalAppContextMenu(
                            details.globalPosition,
                            permissions: permissions,
                          );

                      if (selectedAction == null || !context.mounted) return;

                      final isSuccess = await handleLocalAppMenuAction(
                        context,
                        action: selectedAction,
                        localApplicationId: selectedLDLAppId,
                      );

                      if (isSuccess && context.mounted) {
                        context
                            .read<
                              LocalDrivingLicenseApplicationsListScreenCubit
                            >()
                            .getAllLocalDrivingLicenseApplications();
                      }
                    },
                    columns: _buildGridColumns(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<GridColumn> _buildGridColumns() {
    const columnMap = {
      'L.D.L.ApplicationID': 'L.D.L.Application ID',
      'DrivingClass': 'Driving Class',
      'NationalNo': 'National No',
      'FullName': 'Full Name',
      'ApplicationDate': 'Application Date',
      'PassedTests': 'Passed Tests',
      'Status': 'Status',
    };

    return [
      for (final MapEntry(:key, :value) in columnMap.entries)
        GridColumn(
          columnName: key,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
        ),
    ];
  }
}
