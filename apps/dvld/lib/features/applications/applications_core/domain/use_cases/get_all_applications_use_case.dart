import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';

class GetAllApplicationsUseCase
    extends BaseUseCase<void, List<ApplicationEntity>> {
  final ApplicationsRepository _applicationsRepository;
  GetAllApplicationsUseCase(this._applicationsRepository);
  @override
  Future<Either<Failure, List<ApplicationEntity>>> call([void params]) async =>
      _applicationsRepository.getAllApplications();
}
