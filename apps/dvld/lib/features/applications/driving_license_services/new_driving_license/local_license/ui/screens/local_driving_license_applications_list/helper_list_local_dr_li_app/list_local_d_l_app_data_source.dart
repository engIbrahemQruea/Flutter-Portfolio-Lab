import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ListLocalDLAppDataSource extends DataGridSource {
  ListLocalDLAppDataSource({
    required List<LocalDrivingLicenseApplicationListItemEntity> localDLAppList,
  }) {
    dataGridRows = localDLAppList
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: 'L.D.L.ApplicationID',
                value: dataGridRow.localDrLiAppViewId,
              ),
              DataGridCell<String>(
                columnName: 'DrivingClass',
                value: dataGridRow.className,
              ),
              DataGridCell<String>(
                columnName: 'NationalNo',
                value: dataGridRow.nationalNo,
              ),
              DataGridCell<String>(
                columnName: 'FullName',
                value: dataGridRow.fullName,
              ),
              DataGridCell<String>(
                columnName: 'ApplicationDate',
                value: dataGridRow.applicationDate.toFormattedDateTime,
              ),
              DataGridCell<int>(
                columnName: 'PassedTests',
                value: dataGridRow.passedTestCount,
              ),
              DataGridCell<String>(
                columnName: 'Status',
                value: dataGridRow.status,
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
              (dataGridCell.columnName == 'L.D.L.ApplicationID' ||
                  dataGridCell.columnName == 'NationalNo' ||
                  dataGridCell.columnName == 'PassedTests' ||
                  dataGridCell.columnName == 'Status')
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
