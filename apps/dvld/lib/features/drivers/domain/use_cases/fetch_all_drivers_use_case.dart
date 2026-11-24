import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/drivers/domain/entities/read_entity/drivers_item_entity.dart';
import 'package:dvld/features/drivers/domain/repositories/drivers_repository.dart';

class FetchAllDriversUseCase
    extends BaseUseCaseNoParams<List<DriversItemEntity>> {
  final DriversRepository _repository;

  FetchAllDriversUseCase(this._repository);

  @override
  Future<Either<Failure, List<DriversItemEntity>>> call() =>
      _repository.fetchAllDrivers();
}
