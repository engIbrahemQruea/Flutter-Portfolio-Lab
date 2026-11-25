import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class DetainLicenseItemEntity extends Equatable {
  final int detainID;
  final int licenseID;
  final DateTime detainDate;
  final bool isReleased;
  final double fineFees;
  final DateTime? releaseDate;
  final String nationalNo;
  final int personID;
  final String fullName;
  final int? releaseApplicationID;

  const DetainLicenseItemEntity({
    required this.detainID,
    required this.licenseID,
    required this.detainDate,
    required this.isReleased,
    required this.fineFees,
    this.releaseDate,
    required this.nationalNo,
    required this.personID,
    required this.fullName,
    this.releaseApplicationID,
  });

  @override
  List<Object?> get props => [
    detainID,
    licenseID,
    detainDate,
    isReleased,
    fineFees,
    releaseDate,
    nationalNo,
    personID,
    fullName,
    releaseApplicationID,
  ];
}
