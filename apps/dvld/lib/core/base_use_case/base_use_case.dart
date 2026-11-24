import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class BaseUseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}
