import 'package:dvld/features/licenses/international_license/domain/entities/read_entity/international_license_details_read_entity.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_international_license_details_by_international_id_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_international_license_info_cubit_state.dart';

class ShowInternationalLicenseInfoCubit
    extends Cubit<ShowInternationalLicenseInfoCubitState> {
  ShowInternationalLicenseInfoCubit(
    this._getInternationalLicenseDetailsByInternationalIdUseCase,
  ) : super(ShowInternationalLicenseInfoCubitInitial());

  final GetInternationalLicenseDetailsByInternationalIdUseCase
  _getInternationalLicenseDetailsByInternationalIdUseCase;

  Future<void> getInternationalLicenseDetailsByInternationalId({
    required int internationalLicenseId,
  }) async {
    if (internationalLicenseId == null || internationalLicenseId == 0) {
      emit(
        ShowInternationalLicenseInfoCubitFailure(
          message: 'international License ID is null ',
        ),
      );
      return;
    }
    emit(ShowInternationalLicenseInfoCubitLoading());
    final result = await _getInternationalLicenseDetailsByInternationalIdUseCase
        .call(internationalLicenseId);
    result.fold(
      (failure) => emit(
        ShowInternationalLicenseInfoCubitFailure(message: failure.message),
      ),
      (internationalLicenseDetails) => emit(
        ShowInternationalLicenseInfoCubitLoaded(
          internationalLicenseDetailsReadEntity: internationalLicenseDetails,
        ),
      ),
    );
  }
}
