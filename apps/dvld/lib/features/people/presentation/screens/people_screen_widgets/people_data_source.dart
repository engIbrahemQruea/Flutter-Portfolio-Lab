import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PeopleDataSource extends DataGridSource {
  PeopleDataSource({required List<PeopleEntity> people}) {
    dataGridRows = people
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: 'person_id',
                value: dataGridRow.personId,
              ),
              DataGridCell<String>(
                columnName: 'national_no',
                value: dataGridRow.nationalNo,
              ),
              DataGridCell<String>(
                columnName: 'first_name',
                value: dataGridRow.firstName,
              ),
              DataGridCell<String>(
                columnName: 'second_name',
                value: dataGridRow.secondName,
              ),
              DataGridCell<String>(
                columnName: 'third_name',
                value: dataGridRow.thirdName,
              ),
              DataGridCell<String>(
                columnName: 'last_name',
                value: dataGridRow.lastName,
              ),
              DataGridCell<String>(
                columnName: 'gender',
                value: dataGridRow.gender == 1 ? 'Male' : 'Female',
              ),
              DataGridCell<String>(
                columnName: 'date_of_birth',
                value: dataGridRow.dateOfBirth,
              ),
              DataGridCell<String>(
                columnName: 'email',
                value: dataGridRow.email,
              ),
              DataGridCell<String>(
                columnName: 'phone',
                value: dataGridRow.phone,
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
              (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
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
