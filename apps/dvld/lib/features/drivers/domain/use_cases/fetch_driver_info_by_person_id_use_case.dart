import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/drivers/domain/entities/drivers_entity.dart';
import 'package:dvld/features/drivers/domain/repositories/drivers_repository.dart';

class FetchDriverInfoByPersonIdUseCase extends BaseUseCase<DriversEntity, int> {
  final DriversRepository _driversRepository;

  FetchDriverInfoByPersonIdUseCase(this._driversRepository);

  @override
  Future<Either<Failure, DriversEntity>> call(int personId) async {
    return await _driversRepository.fetchDriverInfoByPersonId(
      personId: personId,
    );
  }
}
