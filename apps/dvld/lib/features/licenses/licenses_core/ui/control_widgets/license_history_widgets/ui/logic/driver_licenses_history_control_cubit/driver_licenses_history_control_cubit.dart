import 'package:dvld/features/drivers/domain/use_cases/fetch_driver_info_by_person_id_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/read_entity/local_license_history_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/get_both_info_licenses_local_and_international_use_case.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'driver_licenses_history_control_cubit_state.dart';

class DriverLicensesHistoryControlCubit
    extends Cubit<DriverLicensesHistoryControlCubitState> {
  DriverLicensesHistoryControlCubit(
    this._getBothInfoLicensesLocalAndInternationalUseCase,
    this._fetchDriverInfoByPersonIdUseCase,
  ) : super(DriverLicensesHistoryControlCubitInitial());

  final GetBothInfoLicensesLocalAndInternationalUseCase
  _getBothInfoLicensesLocalAndInternationalUseCase;
  final FetchDriverInfoByPersonIdUseCase _fetchDriverInfoByPersonIdUseCase;

  Future<void> loadInfoByDriverId({required int driverId}) async {
    emit(DriverLicensesHistoryControlCubitLoading());
    await _loadBothLicenses(driverId: driverId);
  }

  Future<void> loadInfoByPersonId({required int personId}) async {
    emit(DriverLicensesHistoryControlCubitLoading());
    final driverInfoResult = await _fetchDriverInfoByPersonIdUseCase.call(
      personId,
    );

    driverInfoResult.fold(
      (failure) => emit(
        DriverLicensesHistoryControlCubitFailure(
          failureMessage: 'Failed to load driver info: ${failure.message}',
        ),
      ),
      (driverInfo) async {
        if (driverInfo == null || driverInfo.driverID == null) {
          emit(
            DriverLicensesHistoryControlCubitEmpty(
              message:
                  'No driver information found for the provided person ID $personId.',
            ),
          );
          return;
        }
        await _loadBothLicenses(driverId: driverInfo.driverID!);
      },
    );
  }

  void clearState() =>
      emit(DriverLicensesHistoryControlCubitEmpty(message: 'State cleared.'));

  Future<void> _loadBothLicenses({required int driverId}) async {
    final result = await _getBothInfoLicensesLocalAndInternationalUseCase.call(
      driverId: driverId,
    );

    result.fold(
      (failure) => emit(
        DriverLicensesHistoryControlCubitFailure(
          failureMessage: 'Failed to load licenses: ${failure.message}',
        ),
      ),
      (licenses) => emit(
        DriverLicensesHistoryControlCubitLoaded(
          localLicenses: licenses.localLicenses,
          internationalLicenses: licenses.internationalLicenses,
        ),
      ),
    );
  }
}
