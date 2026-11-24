import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/issue_first_license/issue_first_license_data_source.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/issue_first_license_repository.dart';

class IssueFirstLicenseRepositoryImpl implements IssueFirstLicenseRepository {
  IssueFirstLicenseRepositoryImpl(this._dataSource);

  final IssueFirstLicenseDataSource _dataSource;

  @override
  Future<Either<Failure, int>> issueFirstLicense({
    required int localDLApplicationId,
    String? notes,
    required int createdByUserId,
  }) async {
    try {
      final licenseId = await _dataSource.issueFirstLicense(
        localDLApplicationId: localDLApplicationId,
        notes: notes,
        createdByUserId: createdByUserId,
      );

      return Right(licenseId);
    } on LocalDataException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Failed to issue the first license $e.'));
    }
  }
}
