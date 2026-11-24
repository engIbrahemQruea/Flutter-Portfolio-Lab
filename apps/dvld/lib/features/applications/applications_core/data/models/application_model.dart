import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';

class ApplicationModel extends DataMapper<ApplicationEntity> {
  final int? applicationId;
  final int applicantPersonId;
  final DateTime applicationDate;
  final int applicationTypeId;
  final ApplicationStatus applicationStatus;
  final DateTime lastStatusDate;
  final double paidFees;
  final int createdByUserId;

  const ApplicationModel({
    this.applicationId,
    required this.applicantPersonId,
    required this.applicationDate,
    required this.applicationTypeId,
    this.applicationStatus = ApplicationStatus.newApp,
    required this.lastStatusDate,
    required this.paidFees,
    required this.createdByUserId,
  });

  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      applicationId: map[ApplicationTable.colId] as int?,
      applicantPersonId: map[ApplicationTable.colApplicantPersonId] as int,
      applicationDate: DateTime.parse(
        map[ApplicationTable.colApplicationDate] as String,
      ),
      applicationTypeId: map[ApplicationTable.colApplicationTypeId] as int,
      applicationStatus: ApplicationStatus.fromValue(
        map[ApplicationTable.colApplicationStatus] as int,
      ),
      lastStatusDate: DateTime.parse(
        map[ApplicationTable.colLastStatusDate] as String,
      ),
      paidFees: (map[ApplicationTable.colPaidFees] as num).toDouble(),
      createdByUserId: map[ApplicationTable.colCreatedByUserId] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (applicationId != null) ApplicationTable.colId: applicationId,
      ApplicationTable.colApplicantPersonId: applicantPersonId,
      ApplicationTable.colApplicationDate: applicationDate.toIso8601String(),
      ApplicationTable.colApplicationTypeId: applicationTypeId,
      ApplicationTable.colApplicationStatus: applicationStatus.value,
      ApplicationTable.colLastStatusDate: lastStatusDate.toIso8601String(),
      ApplicationTable.colPaidFees: paidFees,
      ApplicationTable.colCreatedByUserId: createdByUserId,
    };
  }

  ApplicationModel copyWith({
    int? applicationId,
    int? applicantPersonId,
    DateTime? applicationDate,
    int? applicationTypeId,
    ApplicationStatus? applicationStatus,
    DateTime? lastStatusDate,
    double? paidFees,
    int? createdByUserId,
  }) {
    return ApplicationModel(
      applicationId: applicationId ?? this.applicationId,
      applicantPersonId: applicantPersonId ?? this.applicantPersonId,
      applicationDate: applicationDate ?? this.applicationDate,
      applicationTypeId: applicationTypeId ?? this.applicationTypeId,
      applicationStatus: applicationStatus ?? this.applicationStatus,
      lastStatusDate: lastStatusDate ?? this.lastStatusDate,
      paidFees: paidFees ?? this.paidFees,
      createdByUserId: createdByUserId ?? this.createdByUserId,
    );
  }

  factory ApplicationModel.fromEntity(ApplicationEntity applicationEntity) {
    return ApplicationModel(
      applicationId: applicationEntity.applicationId,
      applicantPersonId: applicationEntity.applicantPersonId,
      applicationDate: applicationEntity.applicationDate,
      applicationTypeId: applicationEntity.applicationTypeId,
      applicationStatus: applicationEntity.applicationStatus,
      lastStatusDate: applicationEntity.lastStatusDate,
      paidFees: applicationEntity.paidFees,
      createdByUserId: applicationEntity.createdByUserId,
    );
  }

  @override
  ApplicationEntity mapToEntity() {
    return ApplicationEntity(
      applicationId: applicationId!,
      applicantPersonId: applicantPersonId,
      applicationDate: applicationDate,
      applicationTypeId: applicationTypeId,
      applicationStatus: applicationStatus,
      lastStatusDate: lastStatusDate,
      paidFees: paidFees,
      createdByUserId: createdByUserId,
    );
  }
}
