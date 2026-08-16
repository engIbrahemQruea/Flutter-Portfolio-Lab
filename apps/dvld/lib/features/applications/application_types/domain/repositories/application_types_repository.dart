import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';

/// Abstract repository contract for the application_types feature.
///
/// Belongs to the **domain layer** — no external package dependencies.
/// The implementation lives in
/// `data/repositories/application_types.repository_impl.dart`.
abstract class ApplicationTypesRepository {
  /// Manage application types
  Future<Either<Failure, List<ApplicationTypeEntity>>> getAllApplicationTypes();

  Future<Either<Failure, ApplicationTypeEntity>> getApplicationTypeInfoByID({
    required int applicationType,
  });

  Future<Either<Failure, int>> addNewApplicationType({
    required ApplicationTypeEntity applicationEntity,
  });

  Future<Either<Failure, bool>> updateApplicationType({
    required ApplicationTypeEntity applicationEntity,
  });
}
