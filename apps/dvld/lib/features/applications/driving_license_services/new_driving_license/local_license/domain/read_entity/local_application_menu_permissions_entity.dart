import 'package:equatable/equatable.dart';

final class LocalApplicationMenuPermissionsEntity extends Equatable {
  final bool canEdit;
  final bool canDelete;
  final bool canCancel;

  final bool canScheduleTests;
  final bool canScheduleVisionTest;
  final bool canScheduleWrittenTest;
  final bool canScheduleStreetTest;

  final bool canIssueLicense;
  final bool canShowLicense;
  final bool canShowAppDetails;
  final bool canShowPersonLicenseHistory;

  const LocalApplicationMenuPermissionsEntity({
    required this.canEdit,
    required this.canDelete,
    required this.canCancel,
    required this.canScheduleTests,
    required this.canScheduleVisionTest,
    required this.canScheduleWrittenTest,
    required this.canScheduleStreetTest,
    required this.canIssueLicense,
    required this.canShowLicense,
    required this.canShowAppDetails,
    required this.canShowPersonLicenseHistory,
  });

  @override
  List<Object?> get props => [
    canEdit,
    canDelete,
    canCancel,
    canScheduleTests,
    canScheduleVisionTest,
    canScheduleWrittenTest,
    canScheduleStreetTest,
    canIssueLicense,
    canShowLicense,
    canShowAppDetails,
    canShowPersonLicenseHistory,
  ];
}
