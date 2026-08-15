import 'package:dvld/features/manage_application/application_types/domain/entity/application_type_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ApplicationTypesDataSource extends DataGridSource {
  ApplicationTypesDataSource({required List<ApplicationTypeEntity> appTypes}) {
    dataGridRows = appTypes
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: 'app_type_id',
                value: dataGridRow.applicationTypeId,
              ),
              DataGridCell<String>(
                columnName: 'app_type_title',
                value: dataGridRow.applicationTypeTitle,
              ),
              DataGridCell<double>(
                columnName: 'app_type_fee',
                value: dataGridRow.applicationTypeFees,
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
              (dataGridCell.columnName == 'app_type_id' ||
                  dataGridCell.columnName == 'app_type_fee')
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
