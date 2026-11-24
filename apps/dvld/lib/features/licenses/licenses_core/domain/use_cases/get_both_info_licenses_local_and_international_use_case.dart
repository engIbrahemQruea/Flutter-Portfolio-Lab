import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_driver_international_licenses_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/read_entity/local_license_history_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/get_driver_local_licenses_use_case.dart';

typedef GetBothInfoLicensesLocalAndInternationalUseCaseResult = ({
  List<LocalLicenseHistoryEntity> localLicenses,
  List<InternationalLicenseEntity> internationalLicenses,
});

class GetBothInfoLicensesLocalAndInternationalUseCase {
  const GetBothInfoLicensesLocalAndInternationalUseCase(
    this._getDriverLocalLicensesUseCase,
    this._getDriverInternationalLicensesUseCase,
  );

  final GetDriverLocalLicensesUseCase _getDriverLocalLicensesUseCase;
  final GetDriverInternationalLicensesUseCase
  _getDriverInternationalLicensesUseCase;

  Future<Either<Failure, GetBothInfoLicensesLocalAndInternationalUseCaseResult>>
  call({required int driverId}) async {
    final (localLicensesResult, internationalLicensesResult) = await (
      _getDriverLocalLicensesUseCase.call(driverId: driverId),
      _getDriverInternationalLicensesUseCase.call(driverId),
    ).wait;

    if (localLicensesResult.isLeft() && internationalLicensesResult.isLeft()) {
      final failure = localLicensesResult.fold(
        (err) => err,
        (_) => internationalLicensesResult.fold(
          (err) => err,
          (_) => throw StateError('Unreachable'),
        ),
      );
      return Left(failure);
    }

    final localLicenses = localLicensesResult.getOrElse(
      () => const <LocalLicenseHistoryEntity>[],
    );
    final internationalLicenses = internationalLicensesResult.getOrElse(
      () => const <InternationalLicenseEntity>[],
    );

    return Right((
      localLicenses: localLicenses,
      internationalLicenses: internationalLicenses,
    ));
  }
}
