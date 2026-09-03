import 'package:dvld/features/applications/application_types/data/index_data_application_type.dart';
import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';

/// Concrete implementation of [ApplicationTypesRepository].
///
/// Add dependencies only when this feature actually needs external I/O
/// or integration points, then register the binding in your DI setup.

class ApplicationTypesRepositoryImpl implements ApplicationTypesRepository {
  const ApplicationTypesRepositoryImpl(this._applicationLocalDataSource);

  final ApplicationTypesLocalDataSource _applicationLocalDataSource;

  @override
  Future<Either<Failure, List<ApplicationTypeEntity>>>
  getAllApplicationTypes() async {
    try {
      final appTypeModels = await _applicationLocalDataSource
          .getAllApplicationTypes();
      return Right(appTypeModels.map((model) => model.mapToEntity()).toList());
    } on LocalDatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ApplicationTypeEntity>> getApplicationTypeInfoByID({
    required int applicationType,
  }) async {
    try {
      final appTypeModel = await _applicationLocalDataSource
          .getApplicationTypeById(applicationTypeId: applicationType);
      return Right(appTypeModel.mapToEntity());
    } on NotFoundFailure catch (e) {
      return Left(NotFoundFailure(e.message));
    } on LocalDatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> addNewApplicationType({
    required ApplicationTypeEntity applicationEntity,
  }) async {
    try {
      final appTypeModelInput = ApplicationTypeModel.fromEntity(
        applicationEntity,
      );
      final currentId = await _applicationLocalDataSource.addNewApplicationType(
        applicationTypeModel: appTypeModelInput,
      );
      return Right(currentId);
    } on LocalDatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateApplicationType({
    required ApplicationTypeEntity applicationEntity,
  }) async {
    try {
      final appTypeModelInput = ApplicationTypeModel.fromEntity(
        applicationEntity,
      );
      final result = await _applicationLocalDataSource.updateApplicationType(
        applicationTypeModel: appTypeModelInput,
      );
      return Right(result);
    } on NotFoundFailure catch (e) {
      return Left(NotFoundFailure(e.message));
    } on LocalDatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
