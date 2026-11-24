import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';

class AddApplicationUseCase
    extends BaseUseCase<int, ApplicationEntity> {
  final ApplicationsRepository applicationsRepository;
  AddApplicationUseCase(this.applicationsRepository);
  @override
  Future<Either<Failure, int>> call([
    ApplicationEntity? applicationEntity,
  ]) async {
    return applicationsRepository.addNewApplication(
      applicationEntity: applicationEntity!,
    );
  }
}
