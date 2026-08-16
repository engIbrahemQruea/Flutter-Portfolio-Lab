import 'package:dvld/core/helpers/type_def.dart';
import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/applications/application_types/data/data_sources/application_type_table.dart';
import 'package:dvld/features/applications/application_types/domain/entity/application_type_entity.dart';
import 'package:equatable/equatable.dart';

class ApplicationTypeModel extends DataMapper<ApplicationTypeEntity>
    with Equatable {
  const ApplicationTypeModel({
    this.applicationTypeId,
    required this.applicationTypeTitle,
    required this.applicationTypeFees,
  });

  final int? applicationTypeId;
  final String applicationTypeTitle;
  final double applicationTypeFees;

  factory ApplicationTypeModel.fromMap(Map<String, dynamic> map) {
    return ApplicationTypeModel(
      applicationTypeId: map[ApplicationTypeTable.colId] as int?,
      applicationTypeTitle: map[ApplicationTypeTable.colTitle] as String,
      applicationTypeFees: (map[ApplicationTypeTable.colFees] as num)
          .toDouble(),
    );
  }

  JsonMap toMap() => {
    if (applicationTypeId != null)
      ApplicationTypeTable.colId: applicationTypeId,
    ApplicationTypeTable.colTitle: applicationTypeTitle,
    ApplicationTypeTable.colFees: applicationTypeFees,
  };

  @override
  ApplicationTypeEntity mapToEntity() => ApplicationTypeEntity(
    applicationTypeId: applicationTypeId,
    applicationTypeTitle: applicationTypeTitle,
    applicationTypeFees: applicationTypeFees,
  );

  factory ApplicationTypeModel.fromEntity(ApplicationTypeEntity entity) {
    return ApplicationTypeModel(
      applicationTypeId: entity.applicationTypeId,
      applicationTypeTitle: entity.applicationTypeTitle,
      applicationTypeFees: entity.applicationTypeFees,
    );
  }

  @override
  List<Object?> get props => [applicationTypeId, applicationTypeTitle];
}
