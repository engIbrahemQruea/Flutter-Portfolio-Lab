import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/test_types/domain/entities/test_type_entity.dart';

/// Abstract repository contract for the test_types feature.
///
/// Belongs to the **domain layer** — no external package dependencies.
/// The implementation lives in
/// `data/repositories/test_types.repository_impl.dart`.
abstract class TestTypesRepository {
  Future<Either<Failure, TestTypeEntity>> getTestTypeInfoByID({
    required int testType,
  });

  Future<Either<Failure, List<TestTypeEntity>>> getAllTestTypes();

  Future<Either<Failure, int>> addNewTestType({
    required TestTypeEntity testTypeEntity,
  });

  Future<Either<Failure, bool>> updateTestType({
    required TestTypeEntity testTypeEntity,
  });
}
