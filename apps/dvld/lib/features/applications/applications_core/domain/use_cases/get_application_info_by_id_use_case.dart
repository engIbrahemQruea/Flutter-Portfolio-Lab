import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';

class GetApplicationInfoByIDUseCase
    extends BaseUseCase<ApplicationEntity, int> {
  final ApplicationsRepository _applicationsRepository;

  GetApplicationInfoByIDUseCase(this._applicationsRepository);

  @override
  Future<Either<Failure, ApplicationEntity>> call([int? applicationId]) async {
    return _applicationsRepository.getApplicationInfoByID(
      applicationId: applicationId!,
    );
  }
}
