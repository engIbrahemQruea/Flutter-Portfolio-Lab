import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/entitiy/params/type_def.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/entitiy/renew_license_entity.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/use_case/init_renew_license_app_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/use_case/renew_license_app_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'renew_license_app_cubit_state.dart';

class RenewLicenseAppCubit extends Cubit<RenewLicenseAppCubitState> {
  RenewLicenseAppCubit(
    this._initRenewLicenseAppUseCase,
    this._renewLicenseAppUseCase,
  ) : super(RenewLicenseAppCubitInitial());

  final InitRenewLicenseAppUseCase _initRenewLicenseAppUseCase;

  final RenewLicenseAppUseCase _renewLicenseAppUseCase;

  Future<void> initRenewLicenseApp({required int licenseId}) async {
    emit(RenewLicenseAppCubitLoading());

    final result = await _initRenewLicenseAppUseCase.call(licenseId: licenseId);

    result.fold(
      (failure) =>
          emit(RenewLicenseAppCubitFailure(errorMessage: failure.message)),
      (renewLicenseEntity) {
        if (!renewLicenseEntity.isLicenseExpired) {
          return emit(
            RenewLicenseAppCubitLoaded(
              renewLicenseEntity: renewLicenseEntity,
              canRenew: false,
              showLicenseInfoHistory: true,
              errorMessage:
                  'Selected License is not yet expiared, it will expire on ${renewLicenseEntity.licenseEntity.expirationDate.toFormattedDate}',
            ),
          );
        }
        if (!renewLicenseEntity.isLicenseActive) {
          return emit(
            RenewLicenseAppCubitLoaded(
              renewLicenseEntity: renewLicenseEntity,
              canRenew: false,
              showLicenseInfoHistory: true,
              errorMessage:
                  ' Selected License is not Not Active, choose an active license.',
            ),
          );
        }
        return emit(
          RenewLicenseAppCubitLoaded(
            renewLicenseEntity: renewLicenseEntity,
            canRenew: true,
            showLicenseInfoHistory: true,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> renewLicense(String notes) async {
    final current = state;
    if (current is! RenewLicenseAppCubitLoaded || !current.canRenew) return;

    emit(RenewLicenseAppCubitLoading());

    final int? oldLicenseId =
        current.renewLicenseEntity.licenseEntity.licenseID;

    if (oldLicenseId != null) {
      final RenewLicenseParam renewParam = (
        oldLicenseId: oldLicenseId,
        createdByUserId: current.renewLicenseEntity.currentUserId,
        applicationFee: current.renewLicenseEntity.appTypeFees,
        notes: notes,
      );

      final result = await _renewLicenseAppUseCase.call(renewParam);

      result.fold(
        (failure) =>
            emit(RenewLicenseAppCubitFailure(errorMessage: failure.message)),
        (newLicense) => emit(
          RenewLicenseAppCubitSuccess(
            renewLicensePrevious: current.copyWith(
              renewLicenseEntity: current.renewLicenseEntity.copyWith(
                licenseEntity: current.renewLicenseEntity.licenseEntity
                    .copyWith(
                      licenseID: newLicense.newLicenseId,
                      applicationId: newLicense.applicationId,
                    ),
              ),
              canRenew: false,
              showLicenseInfoHistory: true,
              showLicenseInfo: true,
            ),
            filterWidgetEnable: false,
          ),
        ),
      );
    }
  }
}
