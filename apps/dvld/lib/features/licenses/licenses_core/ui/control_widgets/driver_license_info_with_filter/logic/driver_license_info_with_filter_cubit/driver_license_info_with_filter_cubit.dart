import 'package:dvld/features/licenses/licenses_core/domain/entities/license_details_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/fetch_license_details_info_by_id.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'driver_license_info_with_filter_cubit_state.dart';

class DriverLicenseInfoWithFilterCubit
    extends Cubit<DriverLicenseInfoWithFilterCubitState> {
  DriverLicenseInfoWithFilterCubit(this._fetchLicenseDetailsInfoByIdUseCase)
    : super(DriverLicenseInfoWithFilterCubitInitial());

  final FetchLicenseDetailsInfoByIdUseCase _fetchLicenseDetailsInfoByIdUseCase;

  Future<void> findLicenseDetailsInfoById({required int licenseId}) async {
    if (licenseId == 0) {
      emit(
        DriverLicenseInfoWithFilterCubitFailure(
          errorMessage: 'License not found',
        ),
      );
      return;
    }

    emit(DriverLicenseInfoWithFilterCubitLoading());
    final result = await _fetchLicenseDetailsInfoByIdUseCase.call(licenseId);
    result.fold(
      (failure) => emit(
        DriverLicenseInfoWithFilterCubitFailure(errorMessage: failure.message),
      ),
      (licenseInfo) => emit(
        DriverLicenseInfoWithFilterCubitLoaded(
          licenseInfoDetails: licenseInfo,
          licenseId,
        ),
      ),
    );
  }
}
