import 'package:equatable/equatable.dart';

final class LocalDrivingLicenseApplicationListItemEntity extends Equatable {
  final int localDrLiAppViewId;
  final String className;
  final String nationalNo;
  final String fullName;
  final DateTime applicationDate;
  final int passedTestCount;
  final String status;

  const LocalDrivingLicenseApplicationListItemEntity({
    required this.localDrLiAppViewId,
    required this.className,
    required this.nationalNo,
    required this.fullName,
    required this.applicationDate,
    required this.passedTestCount,
    required this.status,
  });

  @override
  List<Object?> get props => [
    localDrLiAppViewId,
    className,
    nationalNo,
    fullName,
    applicationDate,
    passedTestCount,
    status,
  ];
}
