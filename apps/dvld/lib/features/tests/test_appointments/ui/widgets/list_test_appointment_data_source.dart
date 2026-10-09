import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/read_entities/test_appointment_item_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/test_appointment_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ListTestAppointmentsDataSource extends DataGridSource {
  ListTestAppointmentsDataSource({
    required List<TestAppointmentEntity> listTestAppointments,
  }) {
    dataGridRows = listTestAppointments
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: 'testAppointmentID',
                value: dataGridRow.testAppointmentID,
              ),
              DataGridCell<String>(
                columnName: 'appointmentDate',
                value: dataGridRow.appointmentDate.toFormattedDateTime,
              ),
              DataGridCell<double>(
                columnName: 'paidFees',
                value: dataGridRow.paidFees,
              ),
              DataGridCell<bool>(
                columnName: 'isLocked',
                value: dataGridRow.isLocked,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment:
              (dataGridCell.columnName == 'testAppointmentID' ||
                  dataGridCell.columnName == 'paidFees' ||
                  dataGridCell.columnName == 'isLocked')
              ? Alignment.center
              : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}
