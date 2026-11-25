import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class DetainLicensesEntity extends Equatable {
  final int? detainLicenseID;
  final int licenseID;
  final double fineFees;
  final DateTime detainDate;
  final int? isReleased;
  final int createdByUserID;
  final DateTime? releaseDate;
  final int? releasedByUserID;
  final int? releasedByApplicationID;

  const DetainLicensesEntity({
     this.detainLicenseID,
    required this.licenseID,
    required this.fineFees,
    required this.detainDate,
     this.isReleased,
    required this.createdByUserID,
    this.releaseDate,
    this.releasedByUserID,
    this.releasedByApplicationID,
  });

  @override
  List<Object?> get props => [
    detainLicenseID,
    licenseID,
    fineFees,
    detainDate,
    isReleased,
    createdByUserID,
    releaseDate,
    releasedByUserID,
    releasedByApplicationID,
  ];
}
