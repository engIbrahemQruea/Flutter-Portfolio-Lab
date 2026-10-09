import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:equatable/equatable.dart';

class CreateLocalDrivingLicenseApplicationParams extends Equatable {
  final ApplicationEntity applicationEntity;
  final int licenseClassId;
  final int? localDriLiceApplicationId;

  const CreateLocalDrivingLicenseApplicationParams({
    required this.applicationEntity,
    required this.licenseClassId,
    this.localDriLiceApplicationId,
  });

  @override
  List<Object?> get props => [
    applicationEntity, 
    licenseClassId,
    localDriLiceApplicationId,
  ];
}
