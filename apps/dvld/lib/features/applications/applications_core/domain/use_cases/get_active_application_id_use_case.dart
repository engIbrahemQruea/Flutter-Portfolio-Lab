import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';

typedef ActiveParams = ({int applicationTypeId, int personId});

class GetActiveApplicationIDUseCase extends BaseUseCase<int, ActiveParams> {
  final ApplicationsRepository _applicationsRepository;
  GetActiveApplicationIDUseCase(this._applicationsRepository);
  @override
  Future<Either<Failure, int>> call(ActiveParams params) async {
    return _applicationsRepository.getActiveApplicationsID(
      applicationTypeId: params.applicationTypeId,
      personId: params.personId,
    );
  }
}
