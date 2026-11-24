import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/drivers/domain/entities/drivers_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
class DriverModel extends DataMapper<DriversEntity> {
  final int? driverID;
  final int personID;
  final int createdByUserID;
  final DateTime createdDate;

  const DriverModel({
    this.driverID,
    required this.personID,
    required this.createdByUserID,
    required this.createdDate,
  });

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      driverID: map[DriversTable.colDriverID] as int?,
      personID: map[DriversTable.colPersonID] as int,
      createdByUserID: map[DriversTable.colCreatedByUserID] as int,
      createdDate: DateTime.parse(map[DriversTable.colCreatedDate] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (driverID != null) DriversTable.colDriverID: driverID,
      DriversTable.colPersonID: personID,
      DriversTable.colCreatedByUserID: createdByUserID,
      DriversTable.colCreatedDate: createdDate.toSqlFormat(),
    };
  }

  DriverModel copyWith({
    int? driverID,
    int? personID,
    int? createdByUserID,
    DateTime? createdDate,
  }) {
    return DriverModel(
      driverID: driverID ?? this.driverID,
      personID: personID ?? this.personID,
      createdByUserID: createdByUserID ?? this.createdByUserID,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  factory DriverModel.fromEntity(DriversEntity entity) {
    return DriverModel(
      driverID: entity.driverID,
      personID: entity.personID,
      createdByUserID: entity.createdByUserID,
      createdDate: entity.createdDate,
    );
  }

  @override
  DriversEntity mapToEntity() {
    return DriversEntity(
      driverID: driverID,
      personID: personID,
      createdByUserID: createdByUserID,
      createdDate: createdDate,
    );
  }
}

extension on DateTime {
  String toSqlFormat() =>
      toIso8601String().replaceFirst('T', ' ').substring(0, 19);
}
