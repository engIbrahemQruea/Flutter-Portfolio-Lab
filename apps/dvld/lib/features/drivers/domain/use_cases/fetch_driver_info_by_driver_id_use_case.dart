import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/drivers/domain/entities/drivers_entity.dart';
import 'package:dvld/features/drivers/domain/repositories/drivers_repository.dart';

class FetchDriverInfoByDriverIdUseCase extends BaseUseCase<DriversEntity, int> {
  final DriversRepository _driversRepository;

  FetchDriverInfoByDriverIdUseCase(this._driversRepository);
  @override
  Future<Either<Failure, DriversEntity>> call(int params) async {
    return await _driversRepository.fetchDriverInfoById(driverId: params);
  }
}
