import 'package:dvld/features/manage_application/test_types/domain/entities/test_type_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TestTypesDataSource extends DataGridSource {
  TestTypesDataSource({required List<TestTypeEntity> testTypes}) {
    dataGridRows = testTypes
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: 'test_type_id',
                value: dataGridRow.testTypeId,
              ),
              DataGridCell<String>(
                columnName: 'test_type_title',
                value: dataGridRow.testTypeTitle,
              ),
              DataGridCell<String>(
                columnName: 'test_type_description',
                value: dataGridRow.testTypeDescription,
              ),
              DataGridCell<double>(
                columnName: 'test_type_fee',
                value: dataGridRow.testTypeFees,
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
              (dataGridCell.columnName == 'test_type_id' ||
                  dataGridCell.columnName == 'test_type_fee')
              ? Alignment.center
              : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: dataGridCell.columnName == 'test_type_description'
              ? Text(
                  dataGridCell.value.toString(),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
        );
      }).toList(),
    );
  }
}
