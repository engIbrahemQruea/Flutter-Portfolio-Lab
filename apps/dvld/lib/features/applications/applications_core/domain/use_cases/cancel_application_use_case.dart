import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';

class CancelApplicationUseCase extends BaseUseCase<bool, int> {
  CancelApplicationUseCase( this._applicationsRepository);

  final ApplicationsRepository _applicationsRepository;

  @override
  Future<Either<Failure, bool>> call([int? applicationId]) async {
    return _applicationsRepository.updateApplicationStatus(
      applicationId: applicationId!,
      newStatus: ApplicationStatus.cancelled.value,
    );
  }
}
