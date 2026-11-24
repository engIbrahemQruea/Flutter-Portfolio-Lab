import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';

abstract class IssueFirstLicenseRepository {
  Future<Either<Failure, int>> issueFirstLicense({
    required int localDLApplicationId,
     String? notes,
    required int createdByUserId,
  });
}
