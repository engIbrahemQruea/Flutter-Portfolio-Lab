import 'package:dvld/features/applications/application_types/domain/use_cases/get_application_types_info_by_id_use_case.dart';
import 'package:dvld/features/applications/replace_license/domain/entities/param/type_def.dart';
import 'package:dvld/features/applications/replace_license/domain/entities/replace_license_entity.dart';
import 'package:dvld/features/applications/replace_license/domain/use_cases/create_replace_license_use_case.dart';
import 'package:dvld/features/applications/replace_license/domain/use_cases/init_replace_license_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'replace_license_cubit_state.dart';

class ReplaceLicenseCubit extends Cubit<ReplaceLicenseCubitState> {
  ReplaceLicenseCubit(
    this._initReplaceLicenseUseCase,
    this._createReplaceLicenseUseCase,
    this._getApplicationTypesInfoByIDUseCase,
  ) : super(ReplaceLicenseCubitInitial()) {
    init();
  }

  final InitReplaceLicenseUseCase _initReplaceLicenseUseCase;

  final CreateReplaceLicenseUseCase _createReplaceLicenseUseCase;

  final GetApplicationTypesInfoByIDUseCase _getApplicationTypesInfoByIDUseCase;

  Future<void> init() async {
    await _selectReason(IssueReason.replacementForDamaged);
  }

  Future<void> _selectReason(IssueReason reason) async {
    emit(ReplaceLicenseCubitLoading());
    final fees = await _getApplicationTypesInfoByIDUseCase.call(
      reason.applicationType.value,
    );
    fees.fold(
      (failure) =>
          emit(ReplaceLicenseCubitFailure(errorMessage: failure.message)),
      (fees) => emit(
        ReplaceLicenseCubitNotLoaded(
          applicationFees: fees.applicationTypeFees,
          selectedReason: reason,
        ),
      ),
    );
  }

  Future<void> changeReason(IssueReason reason) async {
    final state = this.state;
    if (state is ReplaceLicenseCubitLoaded) {
      final fees = await _getApplicationTypesInfoByIDUseCase.call(
        reason.applicationType.value,
      );
      fees.fold(
        (failure) =>
            emit(ReplaceLicenseCubitFailure(errorMessage: failure.message)),
        (fees) => emit(
          state.copyWith(
            applicationFees: fees.applicationTypeFees,
            selectedReason: reason,
          ),
        ),
      );
    } else {
      await _selectReason(reason);
    }
  }

  Future<void> initReplaceLicense({required int oldLicenseId}) async {
    final state = this.state;
    if (state is! ReplaceLicenseCubitNotLoaded &&
        state is! ReplaceLicenseCubitLoaded) {
      return;
    }
    final reason = state is ReplaceLicenseCubitLoaded
        ? state.selectedReason
        : (state as ReplaceLicenseCubitNotLoaded).selectedReason;
    final fees = state is ReplaceLicenseCubitLoaded
        ? state.applicationFees
        : (state as ReplaceLicenseCubitNotLoaded).applicationFees;

    emit(ReplaceLicenseCubitLoading());

    // final reason=state is ReplaceLicenseCubitLoaded? state.selectedReason:(state as ReplaceLicenseCubitLoaded).selectedReason ;
    final result = await _initReplaceLicenseUseCase.call(
      oldLicenseId: oldLicenseId,
      issueReason: reason,
    );
    result.fold(
      (failure) =>
          emit(ReplaceLicenseCubitFailure(errorMessage: failure.message)),
      (replaceLicenseEntity) {
        if (!replaceLicenseEntity.isLicenseActive) {
          return emit(
            ReplaceLicenseCubitLoaded(
              replaceLicenseEntity: replaceLicenseEntity,
              applicationFees: fees,
              canReplace: false,
              showLicenseInfoHistory: true,
              selectedReason: reason,
              errorMessage:
                  ' Selected License is not Not Active, choose an active license.',
            ),
          );
        }

        return emit(
          ReplaceLicenseCubitLoaded(
            replaceLicenseEntity: replaceLicenseEntity,
            applicationFees: fees,
            canReplace: true,
            showLicenseInfo: true,
            showLicenseInfoHistory: true,
            selectedReason: reason,
          ),
        );
      },
    );
  }

  Future<void> issueReplacement() async {
    final state = this.state;
    if (state is! ReplaceLicenseCubitLoaded || !state.canReplace) return;
    emit(ReplaceLicenseCubitLoading());

    final int? oldLicenseId =
        state.replaceLicenseEntity.licenseEntity.licenseID;

    if (oldLicenseId != null) {
      final param = (
        oldLicenseId: oldLicenseId,
        reason: state.selectedReason,
        createdByUserId: state.replaceLicenseEntity.currentUserId,
        applicationFee: state.applicationFees,
      );

      final result = await _createReplaceLicenseUseCase.call(param);
      result.fold(
        (failure) =>
            emit(ReplaceLicenseCubitFailure(errorMessage: failure.message)),
        (licenseEntity) => emit(
          ReplaceLicenseCubitSuccess(
            replaceLicenseResult: licenseEntity,
            replaceLicensePrevious: state.copyWith(
              replaceLicenseEntity: state.replaceLicenseEntity,
              applicationFees: state.applicationFees,
              canReplace: state.canReplace,
              showLicenseInfo: state.showLicenseInfo,
              showLicenseInfoHistory: state.showLicenseInfoHistory,
              selectedReason: state.selectedReason,
            ),
            filterWidgetEnable: true,
          ),
        ),
      );
    }
  }
}
