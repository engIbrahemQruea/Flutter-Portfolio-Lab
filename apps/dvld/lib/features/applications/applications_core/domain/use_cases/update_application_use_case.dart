import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';

class UpdateApplicationUseCase extends BaseUseCase<bool, ApplicationEntity> {
  final ApplicationsRepository _applicationsRepository;

  UpdateApplicationUseCase(this._applicationsRepository);

  @override
  Future<Either<Failure, bool>> call([
    ApplicationEntity? applicationEntity,
  ]) async {
    return _applicationsRepository.updateApplication(
      applicationEntity: applicationEntity!,
    );
  }
}
