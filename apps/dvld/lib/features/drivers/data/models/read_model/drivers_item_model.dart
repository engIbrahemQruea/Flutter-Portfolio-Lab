import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_item_table.dart';
import 'package:dvld/features/drivers/domain/entities/read_entity/drivers_item_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
class DriversItemModel extends DataMapper<DriversItemEntity> {
  final int driverID;
  final int personID;
  final String nationalNo;
  final String fullName;
  final DateTime createdDate;
  final int numberOfActiveLicenses;

  const DriversItemModel({
    required this.driverID,
    required this.personID,
    required this.nationalNo,
    required this.fullName,
    required this.createdDate,
    required this.numberOfActiveLicenses,
  });

  factory DriversItemModel.fromMap(Map<String, dynamic> map) {
    return DriversItemModel(
      driverID: map[DriversView.colDriverID] as int,
      personID: map[DriversView.colPersonID] as int,
      nationalNo: map[DriversView.colNationalNo] as String,
      fullName: map[DriversView.colFullName] as String,
      createdDate: DateTime.parse(map[DriversView.colCreatedDate] as String),
      numberOfActiveLicenses: map[DriversView.colNumberOfActiveLicenses] as int,
    );
  }

  @override
  DriversItemEntity mapToEntity() {
    return DriversItemEntity(
      driverID: driverID,
      personID: personID,
      nationalNo: nationalNo,
      fullName: fullName,
      createdDate: createdDate,
      numberOfActiveLicenses: numberOfActiveLicenses,
    );
  }
}
