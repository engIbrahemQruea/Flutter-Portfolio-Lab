import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';

class GetAllLicenseClassesUseCase
    extends BaseUseCase<List<LicenseClassEntity>, BaseUseCaseNoParams> {
  final LocalDrivingLicenseApplicationRepository
  localDrivingLicenseApplicationRepository;

  GetAllLicenseClassesUseCase(this.localDrivingLicenseApplicationRepository);

  @override
  Future<Either<Failure, List<LicenseClassEntity>>> call([
    BaseUseCaseNoParams? noParams,
  ]) => localDrivingLicenseApplicationRepository.getAllLicenseClasses();
}
