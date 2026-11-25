import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/detain_licenses_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/use_cases/add_detain_license_use_case.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/use_cases/is_license_detained_use_case.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:dvld/features/login/domain/login_use_cases/get_data_shared_pref_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detain_license_cubit_state.dart';

class DetainLicenseCubit extends Cubit<DetainLicenseCubitState> {
  DetainLicenseCubit(
    this._getDataSharedPrefUseCase,
    this._isLicenseDetainedUseCase,
    this._addDetainLicenseUseCase,
  ) : super(DetainLicenseCubitInitial());

  final GetDataSharedPrefUseCase _getDataSharedPrefUseCase;
  final IsLicenseDetainedUseCase _isLicenseDetainedUseCase;

  final AddDetainLicenseUseCase _addDetainLicenseUseCase;

  LoginEntity? _cachedLoginEntity;

  void initialize() async {
    emit(DetainLicenseCubitLoading());
    final loginEntity = await _getDataSharedPrefUseCase.call(
      stringKey: sharedPrefKeyCurrentUser,
    );
    if (loginEntity?.userName == null) {
      emit(DetainLicenseCubitFailure('User not logged in.'));
      return;
    }

    _cachedLoginEntity = loginEntity;
    emit(DetainNoLicenseCubit(loginEntity!));
  }

  Future<void> onLicenseSelected({required int licenseId}) async {
    if (_cachedLoginEntity == null) {
      emit(
        DetainLicenseCubitFailure(
          'User session not found. Please re-initialize.',
        ),
      );
      return;
    }

    if (licenseId == 0) {
      emit(DetainNoLicenseCubit(_cachedLoginEntity!));
      return;
    }

    final result = await _isLicenseDetainedUseCase.call(licenseId);

    result.fold((failure) => emit(DetainLicenseCubitFailure(failure.message)), (
      isDetained,
    ) {
      if (isDetained) {
        emit(
          DetainLicenseCubitLoaded(
            detainNoLicenseCubit: DetainNoLicenseCubit(_cachedLoginEntity!),
            licenseID: licenseId,
            errorMessage:
                'This license is already detained , choose another license.',
            canDetain: false,
          ),
        );
        return;
      }
      emit(
        DetainLicenseCubitLoaded(
          detainNoLicenseCubit: DetainNoLicenseCubit(_cachedLoginEntity!),
          licenseID: licenseId,
          canDetain: true,
        ),
      );
    });
  }

  Future<void> detainLicense(double fineFees) async {
    final state = this.state;

    if (state is! DetainLicenseCubitLoaded || !state.canDetain)
    {  return ;}

    emit(DetainLicenseCubitProcessing(state));
    final param = DetainLicensesEntity(
      licenseID: state.licenseID!,
      fineFees: fineFees,
      detainDate: state.detainNoLicenseCubit.detainDate!,
      createdByUserID: state.detainNoLicenseCubit.loginEntity.userId!,
    );
    final result = await _addDetainLicenseUseCase.call(param);
    result.fold((failure) => emit(DetainLicenseCubitFailure(failure.message)), (
      newDetainLicenseID,
    ) {
      emit(DetainLicenseCubitSuccess(state, newDetainLicenseID));
    });
  }
}
