import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/manage_application/test_types/data/index_data_test_type.dart';


/// Concrete implementation of [TestTypesRepository].
///
/// Add dependencies only when this feature actually needs external I/O
/// or integration points, then register the binding in your DI setup.
class TestTypesRepositoryImpl implements TestTypesRepository {
  const TestTypesRepositoryImpl(this._testTypeLocalDataSource);

  final TestTypeLocalDataSource _testTypeLocalDataSource;

  @override
  Future<Either<Failure, int>> addNewTestType({
    required TestTypeEntity testTypeEntity,
  }) async {
    try {
      final testTypeModel = TestTypeModel.fromEntity(testTypeEntity);
      final currentId = await _testTypeLocalDataSource.addNewTestType(
        testTypeModel: testTypeModel,
      );
      return Right(currentId);
    } on LocalDatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TestTypeEntity>>> getAllTestTypes() async {
    try {
      final testTypeModels = await _testTypeLocalDataSource.getAllTestTypes();
      return Right(testTypeModels.map((model) => model.mapToEntity()).toList());
    } on LocalDatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TestTypeEntity>> getTestTypeInfoByID({
    required int testType,
  }) async {
    try {
      final testTypeModel = await _testTypeLocalDataSource.getTestTypeById(
        testTypeId: testType,
      );
      return Right(testTypeModel.mapToEntity());
    } on NotFoundFailure catch (e) {
      return Left(NotFoundFailure(e.message));
    } on LocalDatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTestType({
    required TestTypeEntity testTypeEntity,
  }) async {
    try {
      final testTypeInput = TestTypeModel.fromEntity(testTypeEntity);

      final result = await _testTypeLocalDataSource.updateTestType(
        testTypeModel: testTypeInput,
      );
      return Right(result);
    } on NotFoundFailure catch (e) {
      return Left(NotFoundFailure(e.message));
    } on LocalDatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
