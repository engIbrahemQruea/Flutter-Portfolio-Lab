import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/drivers/ui/logic/drivers_screen_cubit/drivers_screen_cubit.dart';
import 'package:dvld/features/drivers/ui/screen/widgets/driver_filter_bar.dart';
import 'package:dvld/features/drivers/ui/screen/widgets/driver_show_context_menu.dart';
import 'package:dvld/features/drivers/ui/screen/widgets/drivers_table_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DriversTable extends StatelessWidget {
  const DriversTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriversScreenCubit, DriversScreenCubitState>(
      builder: (context, state) {
        if (state is DriversScreenCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DriversScreenCubitFailure) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is DriversScreenCubitLoaded) {
          final driversLists = state.filtered;

          return Column(
            children: [
              DriverFilterBar(
                filterValue: state.filterValue,
                selectedColumn: state.filterColumn,
                onColumnChanged: (c) => context
                    .read<DriversScreenCubit>()
                    .onFilterChanged(column: c),
                onValueChanged: (v) => context
                    .read<DriversScreenCubit>()
                    .onFilterChanged(value: v),
              ),

              verticalSpace(20),
              if (driversLists.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 18.0,
                    ),
                    child: Text(
                      'No drivers found matching your search criteria.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
              SfDataGrid(
                source: DriversTableDataSource(listDrivers: state.filtered),
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
                    'Total Records: ${state.filtered.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                onCellSecondaryTap: (details) async {
                  final rowIndex = details.rowColumnIndex.rowIndex;
                  if (rowIndex <= 0 || rowIndex > driversLists.length) return;

                  final selectedDriver = driversLists[rowIndex - 1];
                  final selectedPersonId = selectedDriver.personID;

                  // final cubit = context
                  //     .read<
                  //       LocalDrivingLicenseApplicationsListScreenCubit
                  //     >();

                  // await cubit.getLocalApplicationMenuPermissions(
                  //   localDLAppItemEntity: selectedApp,
                  // );

                  if (!context.mounted) return;

                  // final permissions = cubit.state.permissionsMenu;
                  // if (permissions == null) return;

                  final selectedAction = await context.showDriverContextMenu(
                    details.globalPosition,
                  );

                  if (selectedAction == null || !context.mounted) return;

                  final isSuccess = await handleDriverMenuAction(
                    context,
                    selectedAction,
                    selectedPersonId,
                  );

                  if (isSuccess && context.mounted) {
                    //   context
                    //       .read<
                    //         LocalDrivingLicenseApplicationsListScreenCubit
                    //       >()
                    //       .getAllLocalDrivingLicenseApplications();
                  }
                },
                columns: _buildGridColumns(),
              ),
            ],
          );
        }
        return const Center(
          child: Text('No drivers found matching your search criteria.'),
        );
      },
    );
  }

  List<GridColumn> _buildGridColumns() {
    const columnMap = {
      'driverID': 'Driver ID',
      'personID': 'Person ID',
      'nationalNo': 'National No',
      'fullName': 'FullName',
      'createdDate': 'Created Date',
      'activeLicenses': 'Active Licenses',
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
