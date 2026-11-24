import 'package:equatable/equatable.dart';

final class DriversItemEntity extends Equatable {
  final int driverID;
  final int personID;
  final String nationalNo;
  final String fullName;
  final DateTime createdDate;
  final int numberOfActiveLicenses;

  const DriversItemEntity({
    required this.driverID,
    required this.personID,
    required this.nationalNo,
    required this.fullName,
    required this.createdDate,
    required this.numberOfActiveLicenses,
  });

  @override
  List<Object?> get props => [
    driverID,
    personID,
    nationalNo,
    fullName,
    createdDate,
    numberOfActiveLicenses,
  ];
}
