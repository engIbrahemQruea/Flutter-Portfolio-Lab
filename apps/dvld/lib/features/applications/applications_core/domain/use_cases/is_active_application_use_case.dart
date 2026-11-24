import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';

class IsActiveApplicationUseCase extends BaseUseCase<bool, int> {
  final ApplicationsRepository _applicationsRepository;
  IsActiveApplicationUseCase(this._applicationsRepository);
  @override
  Future<Either<Failure, bool>> call([int? params]) async =>
      _applicationsRepository.isApplicationExists(applicationId: params!);
}
