import 'package:dvld/features/tests/test_appointments/ui/widgets/list_test_appointment_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TestAppointmentsTable extends StatelessWidget {
  const TestAppointmentsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: ListTestAppointmentsDataSource(listTestAppointments: []),
      selectionMode: SelectionMode.single,
      allowSorting: true,
      allowFiltering: true,
      showColumnHeaderIconOnHover: true,
      columnWidthMode: ColumnWidthMode.auto,
      columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      footer: Center(
        child: Text(
          r'Total Records: ${state.applicationsList.length}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      onCellSecondaryTap: (details) async {
        final rowIndex = details.rowColumnIndex.rowIndex;
        // if (rowIndex <= 0 || rowIndex > lDLAppList.length) return;

        // final selectedApp = lDLAppList[rowIndex - 1];
        //final selectedLDLAppId = selectedApp.localDrLiAppViewId;

        // final cubit = context
        //     .read<
        //       LocalDrivingLicenseApplicationsListScreenCubit
        //     >();

        // await cubit.getLocalApplicationMenuPermissions(
        //   localDLAppItemEntity: selectedApp,
        // );

        // if (!context.mounted) return;

        // final permissions = cubit.state.permissionsMenu;
        // if (permissions == null) return;

        // final selectedAction = await context
        //     .showLocalAppContextMenu(
        //       details.globalPosition,
        //       permissions: permissions,
        //     );

        // if (selectedAction == null || !context.mounted) return;

        // final isSuccess = await handleLocalAppMenuAction(
        //   context,
        //   action: selectedAction,
        //   localApplicationId: selectedLDLAppId,
        // );

        // if (isSuccess && context.mounted) {
        //   context
        //       .read<
        //         LocalDrivingLicenseApplicationsListScreenCubit
        //       >()
        //       .getAllLocalDrivingLicenseApplications();
        // }
      },
      columns: _buildGridColumns(),
    );
  }

  List<GridColumn> _buildGridColumns() {
    const columnMap = {
      'testAppointmentID': 'testAppointmentID',
      'appointmentDate': 'appointmentDate',
      'paidFees': 'paidFees',
      'isLocked': 'isLocked',
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
