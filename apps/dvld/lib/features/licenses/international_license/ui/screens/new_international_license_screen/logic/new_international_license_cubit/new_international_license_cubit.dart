import 'package:dvld/features/licenses/international_license/domain/entities/param/international_license_issue_result.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/read_entity/new_international_license_read_entity.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_active_international_license_id_by_driver_id_use_case.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_init_details_new_international_license_use_case.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/issue_international_license_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/fetch_license_info_by_license_id_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_international_license_cubit_state.dart';

class NewInternationalLicenseCubit
    extends Cubit<NewInternationalLicenseCubitState> {
  NewInternationalLicenseCubit(
    this._getInitDetailsNewInternationalLicenseUseCase,
    this._getActiveInternationalLicenseUseCase,
    this._fetchLicenseInfoByLicenseIdUseCase,
    this._issueInternationalLicenseUseCase,
  ) : super(NewInternationalLicenseCubitInitial());

  final GetInitDetailsNewInternationalLicenseUseCase
  _getInitDetailsNewInternationalLicenseUseCase;
  final GetActiveInternationalLicenseIdByDriverIdUseCase
  _getActiveInternationalLicenseUseCase;

  final FetchLicenseInfoByLicenseIdUseCase _fetchLicenseInfoByLicenseIdUseCase;

  final IssueInternationalLicenseUseCase _issueInternationalLicenseUseCase;

  NewInternationalLicenseReadEntity? _newInternationalLicenseReadEntity;

  Future<void> getInitDetails() async {
    emit(NewInternationalLicenseCubitLoading());
    final result = await _getInitDetailsNewInternationalLicenseUseCase.call();
    result.fold(
      (failure) =>
          emit(NewInternationalLicenseCubitFailure(message: failure.message)),
      (newInternationalLicenseReadEntity) {
        _newInternationalLicenseReadEntity = newInternationalLicenseReadEntity;
        emit(
          NewInternationalLicenseCubitEmpty(
            newInternationalLicenseReadEntity:
                newInternationalLicenseReadEntity,
          ),
        );
      },
    );
  }

  Future<void> onSelectedLicenseID({required int licenseId}) async {
    emit(NewInternationalLicenseCubitLoading());

    final licenseResult = await _fetchLicenseInfoByLicenseIdUseCase.call(
      licenseId,
    );

    await licenseResult.fold(
      (failure) async {
        emit(NewInternationalLicenseCubitFailure(message: failure.message));
      },
      (licenseEntity) async {
        // 1. Validate local license class.
        if (licenseEntity.licenseClass != 3) {
          emit(
            NewInternationalLicenseCubitLoaded(
              newInterLicePrevState: NewInternationalLicenseCubitEmpty(
                newInternationalLicenseReadEntity:
                    _newInternationalLicenseReadEntity!,
              ),
              licenseId: licenseId,
              message:
                  'Selected license must be Class 3. Select another license.',
              canIssue: false,
            ),
          );
          return;
        }

        // 2. Check for an active international license.
        final activeLicenseResult = await _getActiveInternationalLicenseUseCase
            .call(licenseEntity.driverId);

        final activeLicenseId = activeLicenseResult.fold((failure) {
          emit(NewInternationalLicenseCubitFailure(message: failure.message));
          return null;
        }, (id) => id);

        // 3. Stop if the driver already has an active license.
        if (activeLicenseResult.isLeft()) return;

        if (activeLicenseId != null) {
          emit(
            NewInternationalLicenseCubitLoaded(
              newInterLicePrevState: NewInternationalLicenseCubitEmpty(
                newInternationalLicenseReadEntity:
                    _newInternationalLicenseReadEntity!,
              ),
              internationalLicenseID: activeLicenseId,
              licenseId: licenseId,
              message:
                  'The driver already has an active international license with ID $activeLicenseId.',
              canIssue: false,
            ),
          );
          return;
        }

        // 4. The selected license passed the current checks.
        emit(
          NewInternationalLicenseCubitLoaded(
            newInterLicePrevState: NewInternationalLicenseCubitEmpty(
              newInternationalLicenseReadEntity:
                  _newInternationalLicenseReadEntity!,
            ),
            message: null,
            licenseId: licenseEntity.licenseID,
            canIssue: true,
          ),
        );
      },
    );
  }

  Future<void> issueLicense() async {
    final state = this.state;

    if (state is! NewInternationalLicenseCubitLoaded || !state.canIssue) {
      return;
    }
    emit(NewInternationalLicenseCubitProcessing());

    final param = (
      licenseID: state.licenseId!,
      createdUserID: _newInternationalLicenseReadEntity!.currentUserId,
    );

    final result = await _issueInternationalLicenseUseCase.call(param);
    result.fold(
      (failure) =>
          emit(NewInternationalLicenseCubitFailure(message: failure.message)),
      (internationalLicenseResult) async {
        emit(
          NewInternationalLicenseCubitSuccess(
            newInterLicePrevState: NewInternationalLicenseCubitLoaded(
              newInterLicePrevState: NewInternationalLicenseCubitEmpty(
                newInternationalLicenseReadEntity:
                    _newInternationalLicenseReadEntity!,
              ),
              canIssue: false,
              licenseId: state.licenseId,
            ),
            issueILResult: internationalLicenseResult,
          ),
        );
      },
    );
  }
}
