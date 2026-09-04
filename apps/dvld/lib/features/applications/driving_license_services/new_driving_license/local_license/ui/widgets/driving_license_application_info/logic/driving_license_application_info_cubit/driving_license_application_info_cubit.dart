import 'package:dvld/core/helpers/forms/forms.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/read_entity/local_driving_license_application_details_read_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/get_driving_license_application_info_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'driving_license_application_info_cubit_state.dart';

class DrivingLicenseApplicationInfoCubit
    extends Cubit<DrivingLicenseApplicationInfoCubitState> {
  DrivingLicenseApplicationInfoCubit(
    this._getDrivingLicenseApplicationInfoUseCase,
  ) : super(DrivingLicenseApplicationInfoCubitState());

  final GetDrivingLicenseApplicationInfoUseCase
  _getDrivingLicenseApplicationInfoUseCase;

  Future<void> loadApplicationInfoByLocalDrivingLicenseAppID({
    required int? localDriLiceApplicationId,
  }) async {
    if (localDriLiceApplicationId == null) {
      emit(
        state.copyWith(
          drivingLicenseAppInfoStatus: RequestStatus.failure,
          errorMessage: () => 'localDriLiceApplicationId is null',
        ),
      );
      return;
    }
    emit(state.copyWith(drivingLicenseAppInfoStatus: RequestStatus.loading));

    final result = await _getDrivingLicenseApplicationInfoUseCase.call(
      localDriLiceApplicationId,
    );

    emit(
      result.fold(
        (failure) => state.copyWith(
          drivingLicenseAppInfoStatus: RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
        (localDrLiApplicationEntity) => state.copyWith(
          drivingLicenseAppInfoStatus: RequestStatus.success,
          localDrLiApplicationDetailsReadEntity: localDrLiApplicationEntity,
        ),
      ),
    );
  }
}
