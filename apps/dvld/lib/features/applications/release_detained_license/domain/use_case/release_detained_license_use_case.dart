import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/release_detained_license/domain/entities/param/release_detained_license_param.dart';
import 'package:dvld/features/applications/release_detained_license/domain/repositories/release_detained_license_repository.dart';

class ReleaseDetainedLicenseUseCase
    extends BaseUseCase<int, ReleaseDetainedLicenseParam> {
  final ReleaseDetainedLicenseRepository _releaseDetainedLicenseRepository;
  ReleaseDetainedLicenseUseCase(this._releaseDetainedLicenseRepository);

  @override
  Future<Either<Failure, int>> call(ReleaseDetainedLicenseParam params) async {
    return await _releaseDetainedLicenseRepository.releaseDetainedLicense(
      params: params,
    );
  }
}
