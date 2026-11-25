import 'package:dvld/features/applications/release_detained_license/domain/entities/release_detained_license_read_entity.dart';
import 'package:dvld/features/applications/release_detained_license/domain/use_case/get_release_details_use_case.dart';
import 'package:dvld/features/applications/release_detained_license/domain/use_case/release_detained_license_use_case.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/use_cases/is_license_detained_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'release_detained_license_cubit_state.dart';

class ReleaseDetainedLicenseCubit
    extends Cubit<ReleaseDetainedLicenseCubitState> {
  ReleaseDetainedLicenseCubit(
    this._getReleaseDetailsUseCase,
    this._isLicenseDetainedUseCase,
    this._releaseDetainedLicenseUseCase,
  ) : super(ReleaseDetainedLicenseCubitInitial());

  final GetReleaseDetailsUseCase _getReleaseDetailsUseCase;

  final IsLicenseDetainedUseCase _isLicenseDetainedUseCase;

  final ReleaseDetainedLicenseUseCase _releaseDetainedLicenseUseCase;

  Future<void> getReleaseDetails(int licenseId) async {
    if (licenseId == 0 || licenseId == null) {
      return;
    }

    emit(ReleaseDetainedLicenseCubitLoading());

    final resultIsDetained = await _isLicenseDetainedUseCase.call(licenseId);
    resultIsDetained.fold(
      (failure) =>
          emit(ReleaseDetainedLicenseCubitFailure(message: failure.message)),
      (isDetained) async {
        if (!isDetained) {
          emit(
            ReleaseDetainedLicenseCubitLoaded(
              errorMessage:
                  'Selected license is not detained , choose another license to release.',
              canRelease: false,
            ),
          );
          return;
        }

        final result = await _getReleaseDetailsUseCase.call(
          licenseId: licenseId,
        );
        result.fold(
          (failure) => emit(
            ReleaseDetainedLicenseCubitFailure(message: failure.message),
          ),
          (releaseDetainedLicenseReadEntity) {
            emit(
              ReleaseDetainedLicenseCubitLoaded(
                releaseDetLiReadEntity: releaseDetainedLicenseReadEntity,
                canRelease: true,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> releaseDetainedLicense() async {
    final state = this.state;
    if (state is! ReleaseDetainedLicenseCubitLoaded || !state.canRelease) {
      return;
    }

    emit(
      ReleaseDetainedLicenseCubitProcessing(
        releaseDetLiPrevState: state,
      ),
    );
    final param = (
      detainId:
          state.releaseDetLiReadEntity!.detainLicensesEntity.detainLicenseID!,
      releaseByUserId: state.releaseDetLiReadEntity!.loginEntity.userId!,
      applicationTypeFees: state
          .releaseDetLiReadEntity!
          .applicationTypeEntity
          .applicationTypeFees,
    );
    final result = await _releaseDetainedLicenseUseCase.call(param);
    result.fold(
      (failure) =>
          emit(ReleaseDetainedLicenseCubitFailure(message: failure.message)),
      (newApplicationID) {
        emit(
          ReleaseDetainedLicenseCubitSuccess(
            releaseDetLiPrevState: state,
            applicationID: newApplicationID,
          ),
        );
      },
    );
  }
}
