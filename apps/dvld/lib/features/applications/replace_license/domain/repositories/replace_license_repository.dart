import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/replace_license/domain/entities/param/type_def.dart';

abstract class ReplaceLicenseRepository {
  Future<Either<Failure, ReplaceLicenseResult>> createReplaceLicense({
    required ReplaceLicenseParam licenseParam,
  });
}
