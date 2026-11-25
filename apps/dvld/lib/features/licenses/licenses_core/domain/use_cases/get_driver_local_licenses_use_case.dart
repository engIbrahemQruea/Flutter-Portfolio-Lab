import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/get_license_class_by_license_class_id_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/read_entity/local_license_history_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/repositories/license_repository.dart';

class GetDriverLocalLicensesUseCase {
  final LicenseRepository _licenseRepository;
  final GetLicenseClassByLicenseClassIdUseCase
  _getLicenseClassByLicenseClassIdUseCase;

  GetDriverLocalLicensesUseCase(
    this._licenseRepository,
    this._getLicenseClassByLicenseClassIdUseCase,
  );

  Future<Either<Failure, List<LocalLicenseHistoryEntity>>> call({
    required int driverId,
  }) async {
    final licensesResult = await _licenseRepository
        .fetchDriverLicenseInfoByDriverId(driverId: driverId);

    if (licensesResult.isLeft()) {
      return Left(licensesResult.fold((l) => l, (r) => throw ''));
    }

    final licenses = licensesResult.getOrElse(() => []);
    final List<LocalLicenseHistoryEntity> localLicenseHistoryEntities = [];

    for (var license in licenses) {
      final licenseClassResult = await _getLicenseClassByLicenseClassIdUseCase(
        license.licenseClass,
      );

      if (licenseClassResult.isLeft()) {
        return Left(licenseClassResult.fold((l) => l, (r) => throw ''));
      }

      final licenseClass = licenseClassResult.getOrElse(
        () => throw 'License class not found',
      );

      localLicenseHistoryEntities.add(
        LocalLicenseHistoryEntity(
          licenseEntity: license,
          className: licenseClass.className,
        ),
      );
    }

    return Right(localLicenseHistoryEntities);
  }
}
