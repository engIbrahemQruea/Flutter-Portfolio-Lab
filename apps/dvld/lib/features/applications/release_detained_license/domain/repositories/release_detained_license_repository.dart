

import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/release_detained_license/domain/entities/param/release_detained_license_param.dart';

abstract class ReleaseDetainedLicenseRepository {
  Future<Either<Failure, int>> releaseDetainedLicense({required ReleaseDetainedLicenseParam params});
}