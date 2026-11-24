import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/param/international_license_issue_result.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/param/issue_international_license_param.dart';

abstract class InternationalLicenseRepository {
  Future<Either<Failure, InternationalLicenseEntity>>
  getInternationalLicenseInfoById({required int internationalLicenseId});
  Future<Either<Failure, List<InternationalLicenseEntity>>>
  getAllInternationalLicenses();
  Future<Either<Failure, List<InternationalLicenseEntity>>>
  getDriverInternationalLicenses({required int driverId});
  Future<Either<Failure, int?>> getActiveInternationalLicenseIDByDriverID({
    required int driverId,
  });
  Future<Either<Failure, int>> addNewInternationalLicense({
    required InternationalLicenseEntity internationalLicenseEntity,
  });
  Future<Either<Failure, bool>> updateInternationalLicense({
    required InternationalLicenseEntity internationalLicenseEntity,
  });

  Future<Either<Failure, IssueInternationalLicenseResult>> issueInternationalLicense({required IssueInternationalLicenseParam param});
}
