// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/driving_license_application_info/driving_license_application_info.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_type.dart';
import 'package:dvld/features/tests/schedule_test/ui/screens/widgets/schedule_test_type_presentation_x.dart';
import 'package:dvld/features/tests/test_appointments/ui/logic/test_appointments_list/test_appointments_list_cubit.dart';
import 'package:dvld/features/tests/test_appointments/ui/widgets/list_test_appointment_data_source.dart';
import 'package:dvld/features/tests/test_appointments/ui/widgets/menu_test_appointment/test_appointment_show_context_menu.dart';
import 'package:dvld/features/tests/test_appointments/ui/widgets/test_appointment_title_table_and_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TestAppointmentsListScreen extends StatelessWidget {
  const TestAppointmentsListScreen({super.key, required this.testType});

  final ScheduleTestType testType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(testType.title), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            spacing: 10,
            children: [
              const DrivingLicenseApplicationInfo(),

              TestAppointmentTitleTableAndAddButton(testType: testType),

              BlocBuilder<
                TestAppointmentsListCubit,
                TestAppointmentsListCubitState
              >(
                buildWhen: (previous, current) =>
                    previous.testAppointments != current.testAppointments ||
                    previous.testAppointmentState !=
                        current.testAppointmentState,
                builder: (context, state) {
                  if (state.testAppointmentState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.testAppointmentState.isFailure) {
                    return Center(
                      child: Text(state.errorMessage ?? 'Something went wrong'),
                    );
                  }
                  final testAppointments = state.testAppointments;
                  if (testAppointments == null) {
                    return const Center(
                      child: Text('No test appointments for this application'),
                    );
                  }
                  return Expanded(
                    child: SfDataGrid(
                      source: ListTestAppointmentsDataSource(
                        listTestAppointments: testAppointments,
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
                          'Total Records: ${state.testAppointments!.length}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      onCellSecondaryTap: (details) async {
                        final rowIndex = details.rowColumnIndex.rowIndex;
                        if (rowIndex <= 0 || rowIndex > testAppointments.length)
                          return;

                        final selectedApp = testAppointments[rowIndex - 1];
                        final selectedTestId = selectedApp.testAppointmentID;

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

                        final selectedAction = await context
                            .showTestAppointmentContextMenu(
                              details.globalPosition,
                            );

                        if (selectedAction == null || !context.mounted) return;

                        final isSuccess = await handleTestAppointmentMenuAction(
                          context,
                          selectedAction,
                          selectedTestId!,
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
