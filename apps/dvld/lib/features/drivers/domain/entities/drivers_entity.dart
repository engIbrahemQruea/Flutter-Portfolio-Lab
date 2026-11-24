import 'package:equatable/equatable.dart';

final class DriversEntity extends Equatable {
  final int? driverID;
  final int personID;
  final int createdByUserID;
  final DateTime createdDate;

  const DriversEntity({
    this.driverID,
    required this.personID,
    required this.createdByUserID,
    required this.createdDate,
  });

  @override
  List<Object?> get props => [driverID, personID, createdByUserID, createdDate];
}
