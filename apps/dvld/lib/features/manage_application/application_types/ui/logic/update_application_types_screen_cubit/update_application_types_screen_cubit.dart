import 'package:dvld/core/helpers/extensions_x/string_extensions_x.dart';
import 'package:dvld/core/helpers/forms/forms.dart';
import 'package:dvld/features/manage_application/application_types/domain/index_domain_application_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_application_types_screen_cubit_state.dart';

class UpdateApplicationTypesScreenCubit
    extends Cubit<UpdateApplicationTypesScreenCubitState> {
  UpdateApplicationTypesScreenCubit(
    this._updateApplicationTypesUseCase,
    this._getApplicationTypesInfoByIDUseCase,
  ) : super(const UpdateApplicationTypesScreenCubitState());

  final UpdateApplicationTypesUseCase _updateApplicationTypesUseCase;
  final GetApplicationTypesInfoByIDUseCase _getApplicationTypesInfoByIDUseCase;

  Future<void> loadApplicationTypeById({required int? applicationType}) async {
    if (applicationType == null) {
      emit(
        state.copyWith(
          loadApplicationTypesStatus: RequestStatus.failure,
          errorMessage: () => 'Application Type ID cannot be null',
        ),
      );
      return;
    }

    emit(state.copyWith(loadApplicationTypesStatus: RequestStatus.loading));

    final result = await _getApplicationTypesInfoByIDUseCase.call(
      applicationType,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          loadApplicationTypesStatus: RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (typeInfo) {
        emit(
          state.copyWith(
            loadApplicationTypesStatus: RequestStatus.success,
            applicationTypeId: () => typeInfo.applicationTypeId,
            applicationTypeTitle: state.applicationTypeTitle.copyWith(
              value: () => typeInfo.applicationTypeTitle,
              isValid: true,
              error: () => null,
            ),
            applicationTypeFee: state.applicationTypeFee.copyWith(
              value: () => typeInfo.applicationTypeFees.toString(),
              isValid: true,
              error: () => null,
            ),
          ),
        );
      },
    );
  }

  void onChangeApplicationTypeTitle({required String appTitle}) {
    final trimmedTitle = appTitle.trim();

    if (trimmedTitle.isNullOrEmpty) {
      emit(
        state.copyWith(
          applicationTypeTitle: state.applicationTypeTitle.copyWith(
            value: () => '',
            isValid: false,
            error: () => 'Application Type Title is required',
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        applicationTypeTitle: state.applicationTypeTitle.copyWith(
          value: () => trimmedTitle,
          isValid: true,
          error: () => null,
        ),
      ),
    );
  }

  void onChangeApplicationTypeFee({required String appFee}) {
    final cleanFeeText = appFee.removeSpaces.trim();

    if (cleanFeeText.isNullOrEmpty) {
      emit(
        state.copyWith(
          applicationTypeFee: state.applicationTypeFee.copyWith(
            value: () => '',
            isValid: false,
            error: () => 'Application Type Fee is required',
          ),
        ),
      );
      return;
    }

    final parsedFee = double.tryParse(cleanFeeText);
    if (parsedFee == null) {
      emit(
        state.copyWith(
          applicationTypeFee: state.applicationTypeFee.copyWith(
            value: () => appFee,
            isValid: false,
            error: () => 'Please enter a valid number',
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        applicationTypeFee: state.applicationTypeFee.copyWith(
          value: () => cleanFeeText,
          isValid: true,
          error: () => null,
        ),
      ),
    );
  }

  Future<void> saveButtonApplicationType() async {
    if (!state.isFormValid) {
      emit(
        state.copyWith(
          saveButtonStatus: state.saveButtonStatus.copyWith(
            saveStatus: RequestStatus.failure,
            errorMessage: () => 'Please fill all required fields correctly',
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        saveButtonStatus: state.saveButtonStatus.copyWith(
          saveStatus: RequestStatus.loading,
          errorMessage: () => null,
        ),
      ),
    );

    final parsedFee = double.tryParse(state.applicationTypeFee.value) ?? 0.0;

    final applicationType = ApplicationTypeEntity(
      applicationTypeId: state.applicationTypeId,
      applicationTypeTitle: state.applicationTypeTitle.value,
      applicationTypeFees: parsedFee,
    );

    final result = await _updateApplicationTypesUseCase.call(applicationType);

    result.fold(
      (failure) => emit(
        state.copyWith(
          saveButtonStatus: state.saveButtonStatus.copyWith(
            saveStatus: RequestStatus.failure,
            errorMessage: () => failure.message,
          ),
        ),
      ),
      (_) => emit(
        state.copyWith(
          saveButtonStatus: state.saveButtonStatus.copyWith(
            saveStatus: RequestStatus.success,
            errorMessage: () => null,
          ),
        ),
      ),
    );
  }
}
