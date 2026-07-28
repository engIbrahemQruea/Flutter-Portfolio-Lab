import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserDataSource extends DataGridSource {
  UserDataSource({required List<UserEntity> users}) {
    dataGridRows = users
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: 'user_id',
                value: dataGridRow.userID,
              ),
              DataGridCell<int>(
                columnName: 'person_id',
                value: dataGridRow.personID,
              ),
              DataGridCell<String>(
                columnName: 'user_name',
                value: dataGridRow.userName,
              ),
              DataGridCell<String>(
                columnName: 'password',
                value: dataGridRow.password,
              ),
              DataGridCell<bool>(
                columnName: 'is_active',
                value: dataGridRow.isActive,
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
              (dataGridCell.columnName == 'user_id' ||
                  dataGridCell.columnName == 'person_id')
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
