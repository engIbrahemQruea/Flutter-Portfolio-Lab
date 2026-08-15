import 'package:bloc/bloc.dart';
import 'package:dvld/core/helpers/forms/forms.dart';
import 'package:dvld/features/manage_application/test_types/domain/index_domain_test_type.dart';
import 'package:dvld/features/manage_application/test_types/ui/logic/update_test_types_screen_cubit/inputs/inputs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'update_test_types_screen_cubit_state.dart';

class UpdateTestTypesScreenCubit
    extends Cubit<UpdateTestTypesScreenCubitState> {
  UpdateTestTypesScreenCubit(
    this._getTestTypesInfoByIDUseCase,
    this._updateTestTypesUseCase,
  ) : super(UpdateTestTypesScreenCubitState());

  final UpdateTestTypesUseCase _updateTestTypesUseCase;
  final GetTestTypesInfoByIDUseCase _getTestTypesInfoByIDUseCase;

  Future<void> loadTestTypeInfoById({required int? testTypeId}) async {
    if (testTypeId == null) {
      emit(
        state.copyWith(
          loadTestTypesStatus: RequestStatus.failure,
          errorMessage: () => 'Invalid Test Type Id',
        ),
      );
      return;
    }

    emit(state.copyWith(loadTestTypesStatus: RequestStatus.loading));

    final result = await _getTestTypesInfoByIDUseCase.call(testTypeId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          loadTestTypesStatus: RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (testTypeInfo) => emit(
        state.copyWith(
          loadTestTypesStatus: RequestStatus.success,
          testTypeId: () => testTypeInfo.testTypeId,
          testTypeTitle: TestTypeTitleInput.dirty(testTypeInfo.testTypeTitle),
          testTypeDescription: TestTypeDescriptionInput.dirty(
            testTypeInfo.testTypeDescription,
          ),
          testTypeFee: TestTypeFeesInput.dirty(
            testTypeInfo.testTypeFees.toString(),
          ),
        ),
      ),
    );
  }

  void onChangeTestTypeTitle({required String testTypeTitle}) => emit(
    state.copyWith(testTypeTitle: TestTypeTitleInput.dirty(testTypeTitle)),
  );
  void onChangeTestTypeDescription({required String testTypeDescription}) =>
      emit(
        state.copyWith(
          testTypeDescription: TestTypeDescriptionInput.dirty(
            testTypeDescription,
          ),
        ),
      );
  void onChangeTestTypeFee({required String testTypeFee}) =>
      emit(state.copyWith(testTypeFee: TestTypeFeesInput.dirty(testTypeFee)));

  Future<void> saveButtonTestType() async {
    final testTypeId = state.testTypeId;
    final testTypeTitle = TestTypeTitleInput.dirty(state.testTypeTitle.value);
    final testTypeDescription = TestTypeDescriptionInput.dirty(
      state.testTypeDescription.value,
    );
    final testTypeFees = TestTypeFeesInput.dirty(state.testTypeFee.value);

    if (!state.isFormValid) {
      emit(
        state.copyWith(
          testTypeId: () => testTypeId,
          testTypeTitle: testTypeTitle,
          testTypeDescription: testTypeDescription,
          testTypeFee: testTypeFees,
          saveButtonStatusTestTypes: state.saveButtonStatusTestTypes.copyWith(
            saveStatus: RequestStatus.failure,
            errorMessage: () => 'Please fill all required fields correctly',
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        saveButtonStatusTestTypes: state.saveButtonStatusTestTypes.copyWith(
          saveStatus: RequestStatus.loading,
        ),
      ),
    );

    final parsedFee = double.tryParse(state.testTypeFee.value) ?? 0.0;

    final testType = TestTypeEntity(
      testTypeId: state.testTypeId,
      testTypeTitle: state.testTypeTitle.value,
      testTypeDescription: state.testTypeDescription.value,
      testTypeFees: parsedFee,
    );

    final result = await _updateTestTypesUseCase.call(testType);

    result.fold(
      (failure) => emit(
        state.copyWith(
          saveButtonStatusTestTypes: state.saveButtonStatusTestTypes.copyWith(
            saveStatus: RequestStatus.failure,
            errorMessage: () => failure.message,
          ),
        ),
      ),
      (_) => emit(
        state.copyWith(
          saveButtonStatusTestTypes: state.saveButtonStatusTestTypes.copyWith(
            saveStatus: RequestStatus.success,
          ),
        ),
      ),
    );
  }
}
