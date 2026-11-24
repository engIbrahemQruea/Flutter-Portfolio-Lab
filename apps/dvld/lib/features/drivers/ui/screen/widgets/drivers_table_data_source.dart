import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/features/drivers/domain/entities/read_entity/drivers_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DriversTableDataSource extends DataGridSource {
  DriversTableDataSource({required List<DriversItemEntity> listDrivers}) {
    dataGridRows = listDrivers
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: 'driverID',
                value: dataGridRow.driverID,
              ),
              DataGridCell<int>(
                columnName: 'personID',
                value: dataGridRow.personID,
              ),
              DataGridCell<String>(
                columnName: 'nationalNo',
                value: dataGridRow.nationalNo,
              ),
              DataGridCell<String>(
                columnName: 'fullName',
                value: dataGridRow.fullName,
              ),
              DataGridCell<String>(
                columnName: 'createdDate',
                value: dataGridRow.createdDate.toFormattedDateTime,
              ),
              DataGridCell<int>(
                columnName: 'activeLicenses',
                value: dataGridRow.numberOfActiveLicenses,
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
              (dataGridCell.columnName == 'driverID' ||
                  dataGridCell.columnName == 'personID' ||
                  dataGridCell.columnName == 'nationalNo' ||
                  dataGridCell.columnName == 'activeLicenses')
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
