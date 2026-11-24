import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/replace_license/data/data_sources/replace_license_data_source.dart';
import 'package:dvld/features/applications/replace_license/domain/entities/param/type_def.dart';
import 'package:dvld/features/applications/replace_license/domain/repositories/replace_license_repository.dart';

class ReplaceLicenseRepositoryImpl extends ReplaceLicenseRepository {
  final ReplaceLicenseDataSource _dataSource;

  ReplaceLicenseRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, ReplaceLicenseResult>> createReplaceLicense({
    required ReplaceLicenseParam licenseParam,
  }) async {
    try {
      final result = await _dataSource.createReplaceLicense(
        replaceLicenseParam: licenseParam,
      );
      return Right(result);
    } on LocalDataException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Failed to Create Replace License $e.'));
    }
  }
}
