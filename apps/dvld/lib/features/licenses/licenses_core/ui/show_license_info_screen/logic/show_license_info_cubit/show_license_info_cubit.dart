import 'package:dvld/features/licenses/licenses_core/domain/entities/license_details_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/fetch_license_details_info_by_id.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/fetch_license_id_by_local_app_id_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_license_info_cubit_state.dart';

class ShowLicenseInfoCubit extends Cubit<ShowLicenseInfoCubitState> {
  ShowLicenseInfoCubit(
    this._fetchLicenseDetailsInfoByIdUseCase,
    this._fetchLicenseIdByLocalAppIdUseCase,
  ) : super(ShowLicenseInfoCubitInitial());

  final FetchLicenseDetailsInfoByIdUseCase _fetchLicenseDetailsInfoByIdUseCase;

  final FetchLicenseIdByLocalAppIdUseCase _fetchLicenseIdByLocalAppIdUseCase;

  void fetchLicenseDetailsInfoById({
    required int localDLAppId,
    required int licenseId,
  }) async {
    emit(ShowLicenseInfoCubitLoading());

    if (licenseId != 0) {
      await _getLicenseDetails(licenseId);
      return;
    }

    if (localDLAppId != 0) {
      final result = await _fetchLicenseIdByLocalAppIdUseCase.call(
        localDLAppId,
      );
      result.fold(
        (failure) => emit(ShowLicenseInfoCubitFailure(failure.message)),
        (licenseId) async {
          if (licenseId == null) {
            emit(ShowLicenseInfoCubitFailure('License not found'));
            return;
          }
          await _getLicenseDetails(licenseId);
        },
      );
    }
  }

  Future<void> _getLicenseDetails(int licenseId) async {
    final result = await _fetchLicenseDetailsInfoByIdUseCase.call(licenseId);
    result.fold(
      (failure) => emit(ShowLicenseInfoCubitFailure(failure.message)),
      (licenseInfo) => emit(ShowLicenseInfoCubitLoaded(licenseInfo)),
    );
  }
}
