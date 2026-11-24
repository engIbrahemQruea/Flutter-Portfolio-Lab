import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/core/helpers/forms/forms.dart';
import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';
import 'package:dvld/features/applications/application_types/index_application_types.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:dvld/features/applications/applications_core/domain/use_cases/index_app_core_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/params/create_local_driving_license_application_params.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/index_local_license_use_case.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:dvld/features/login/domain/login_use_cases/get_data_shared_pref_use_case.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_update_local_dr_li_application_screen_cubit_state.dart';

class AddUpdateLocalDrLiApplicationScreenCubit
    extends Cubit<AddUpdateLocalDrLiApplicationScreenCubitState> {
  AddUpdateLocalDrLiApplicationScreenCubit(
    this._getAllLicenseClassesUseCase,
    this._getApplicationTypesInfoByIDUseCase,
    this._getDataSharedPrefUseCase,
    this._getActiveApplicationIDForLicenseClassUseCase,
    this._createLocalDrLiApplicationAndApplicationsUseCase,
    this._getLocalDrLiApplicationInfoByIdUseCase,
    this._updateLocalDrivingLicenseClassUseCase,
  ) : super(AddUpdateLocalDrLiApplicationScreenCubitState());

  final GetAllLicenseClassesUseCase _getAllLicenseClassesUseCase;
  final GetApplicationTypesInfoByIDUseCase _getApplicationTypesInfoByIDUseCase;
  final GetDataSharedPrefUseCase _getDataSharedPrefUseCase;
  final GetActiveApplicationIDForLicenseClassUseCase
  _getActiveApplicationIDForLicenseClassUseCase;
  final CreateLocalDrivingLicenseApplicationAndApplicationsUseCase
  _createLocalDrLiApplicationAndApplicationsUseCase;
  final GetLocalDrivingLicenseApplicationInfoByIdUseCase
  _getLocalDrLiApplicationInfoByIdUseCase;
  final UpdateLocalDrivingLicenseApplicationAndApplicationsUseCase
  _updateLocalDrivingLicenseClassUseCase;

  Future<void> _setApplicationTypeFees() async {
    final applicationType = await _getApplicationTypesInfoByIDUseCase.call(
      EnumApplicationTypes.newLocalDrivingLicense.value,
    );

    applicationType.fold(
      (failure) => emit(
        state.copyWith(
          errorMessage: () => failure.message,
          loadLocalDrLiAppInfoStatus: RequestStatus.failure,
        ),
      ),
      (appType) => emit(
        state.copyWith(
          applicationDate: () => DateTime.now(),
          applicationFee: () => appType.applicationTypeFees,
          loadLocalDrLiAppInfoStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> _setCreatedBy() async {
    final loginEntity = await _getDataSharedPrefUseCase.call(
      stringKey: sharedPrefKeyCurrentUser,
    );
    if (loginEntity != null) {
      emit(state.copyWith(createdByUser: () => loginEntity));
    }
  }

  Future<void> _resetDefaultValues() async {
    await loadLicenseClass();
    if (state.isAddMode) {
      await Future.wait([_setApplicationTypeFees(), _setCreatedBy()]);
    }
  }

  Future<void> _loadData({required int localDrLiApplicationID}) async {
    final result = await _getLocalDrLiApplicationInfoByIdUseCase.call(
      localDrLiApplicationID,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          loadLocalDrLiAppInfoStatus: RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (localDrLiAppEntity) => emit(
        state.copyWith(
          localDriLiceApplicationId: () => localDrLiAppEntity.localDrLiAppId,
          personSelectedId: () =>
              localDrLiAppEntity.applicationEntity?.applicantPersonId,
          selectedLicenseClassId: localDrLiAppEntity.licenseClassId,
          applicationDate: () =>
              localDrLiAppEntity.applicationEntity?.applicationDate,
          applicationFee: () => localDrLiAppEntity.applicationEntity!.paidFees,
          userEntity: () => localDrLiAppEntity.userEntity!,
          screenStatusMode: ScreenStatus.update,
          isApplicationInfoEnabled: false,
          isSaveButtonEnabled: true,
          loadLocalDrLiAppInfoStatus: RequestStatus.success,
        ),
      ),
    );
  }

  Future<void> initAddUpdateLocalDrLiApplicationScreen({
    required int? localDrLiApplicationID,
  }) async {
    if (localDrLiApplicationID == null) {
      emit(
        state.copyWith(
          screenStatusMode: ScreenStatus.add,
          loadLocalDrLiAppInfoStatus: RequestStatus.loading,
        ),
      );
      await _resetDefaultValues();
    } else {
      await _loadData(localDrLiApplicationID: localDrLiApplicationID);
      await _resetDefaultValues();
    }
  }

  void onChangeTabIndex({required int valueIndex}) {
    emit(state.copyWith(selectedTabIndex: valueIndex));
  }

  void onSelectedLicenseClassId({required int valueIndex}) {
    emit(state.copyWith(selectedLicenseClassId: valueIndex));
  }

  void onPersonSelected({required int personID}) {
    emit(state.copyWith(personSelectedId: () => personID));
  }

  void onPressNextButton() {
    if (!state.hasPersonSelectedId) return;

    emit(
      state.copyWith(
        isApplicationInfoEnabled: false,
        isSaveButtonEnabled: true,
        selectedTabIndex: 1,
      ),
    );
  }

  Future<void> loadLicenseClass() async {
    emit(state.copyWith(licenseClassStatus: RequestStatus.loading));

    final result = await _getAllLicenseClassesUseCase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(
          licenseClassStatus: RequestStatus.failure,
          errorMessageLicenseClass: () => failure.message,
        ),
      ),
      (licenseClasses) => emit(
        state.copyWith(
          licenseClassStatus: RequestStatus.success,
          licenseClasses: licenseClasses,
        ),
      ),
    );
  }

  Future<void> onPressSaveButton() async {
    if (state.personSelectedId == null ||
        state.applicationDate == null ||
        state.applicationFee == null) {
      _emitFailure(
        'Please ensure all required fields are filled before saving the application.',
      );
      return;
    }

    final createUserId = state.isAddMode
        ? state.createdByUser?.userId
        : state.userEntity?.userID;

    if (createUserId == null) {
      _emitFailure(
        'User information is missing. Please ensure you are logged in before saving the application.',
      );
      return;
    }

    emit(
      state.copyWith(
        saveButtonStatus: const SaveButtonState(
          saveStatus: RequestStatus.loading,
        ),
      ),
    );

    // /// Check if the person already has a license for the selected license class
    // final isLicenseExistResult = await _isLicenseExistByPersonIdUseCase.call((
    //   personId: state.personSelectedId!,
    //   licenseClassId: state.selectedLicenseClassId,
    // ));

    // bool hasLicenseError = false;
    // bool isLicenseExist = false;

    // isLicenseExistResult.fold((failure) {
    //   hasLicenseError = true;
    //   _emitFailure(
    //     failure.message ?? 'Failed to check existing licenses for this person.',
    //   );
    // }, (exists) => isLicenseExist = exists);

    // if (hasLicenseError) return;

    // if (isLicenseExist) {
    //   _emitFailure(
    //     'Person already has a license with the same applied driving class, Choose diffrent driving class.',
    //   );
    //   return;
    // }

    /// Check for active application for the same person and license class
    final activeAppResult = await _getActiveApplicationIDForLicenseClassUseCase
        .call((
          applicationTypeId: EnumApplicationTypes.newLocalDrivingLicense.value,
          licenseClassId: state.selectedLicenseClassId,
          personId: state.personSelectedId!,
        ));

    bool hasError = false;
    int? activeApplicationID;

    activeAppResult.fold((failure) {
      hasError = true;
      _emitFailure(
        failure.message ?? 'Failed to check available applications.',
      );
    }, (id) => activeApplicationID = id);

    if (hasError) return;

    if (activeApplicationID != null && activeApplicationID != -1) {
      final isAnotherActiveApp =
          state.isAddMode ||
          (activeApplicationID != state.localDriLiceApplicationId);

      if (isAnotherActiveApp) {
        _emitFailure(
          'The selected person already has an active application for this class with ID: $activeApplicationID',
        );
        return;
      }
    }

    final applicationEntity = ApplicationEntity(
      applicationId: state.localDriLiceApplicationId,
      applicantPersonId: state.personSelectedId!,
      applicationDate: state.applicationDate!,
      paidFees: state.applicationFee!,
      applicationStatus: ApplicationStatus.newApp,
      applicationTypeId: EnumApplicationTypes.newLocalDrivingLicense.value,
      createdByUserId: createUserId,
      lastStatusDate: DateTime.now(),
    );

    if (state.isAddMode) {
      await _executeCreateApplication(applicationEntity);
    } else {
      await _executeUpdateApplication(applicationEntity);
    }
  }

  Future<void> _executeCreateApplication(
    ApplicationEntity applicationEntity,
  ) async {
    final params = CreateLocalDrivingLicenseApplicationParams(
      applicationEntity: applicationEntity,
      licenseClassId: state.selectedLicenseClassId,
    );

    final result = await _createLocalDrLiApplicationAndApplicationsUseCase.call(
      params,
    );

    result.fold(
      (failure) => _emitFailure(
        failure.message ?? 'An error occurred while saving the application.',
      ),
      (newLocalDrLiAppId) {
        emit(
          state.copyWith(
            saveButtonStatus: const SaveButtonState(
              saveStatus: RequestStatus.success,
            ),
            localDriLiceApplicationId: () => newLocalDrLiAppId,
          ),
        );
      },
    );
  }

  Future<void> _executeUpdateApplication(
    ApplicationEntity applicationEntity,
  ) async {
    final params = CreateLocalDrivingLicenseApplicationParams(
      applicationEntity: applicationEntity,
      localDriLiceApplicationId: state.localDriLiceApplicationId!,
      licenseClassId: state.selectedLicenseClassId,
    );

    final result = await _updateLocalDrivingLicenseClassUseCase.call(params);

    result.fold(
      (failure) => _emitFailure(
        failure.message ?? 'An error occurred while updating the application.',
      ),
      (_) {
        emit(
          state.copyWith(
            saveButtonStatus: const SaveButtonState(
              saveStatus: RequestStatus.success,
            ),
          ),
        );
      },
    );
  }

  void _emitFailure(String message) {
    emit(
      state.copyWith(
        saveButtonStatus: state.saveButtonStatus.copyWith(
          saveStatus: RequestStatus.failure,
          errorMessage: () => message,
        ),
      ),
    );
  }
}
