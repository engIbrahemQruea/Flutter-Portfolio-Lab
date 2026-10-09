import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/features/login/domain/login_use_cases/get_data_shared_pref_use_case.dart';
import 'package:dvld/features/tests/take_test/domain/entities/take_test_info_read_entity.dart';
import 'package:dvld/features/tests/take_test/domain/use_case/get_take_test_info_use_case.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_entity.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_result_status.dart';
import 'package:dvld/features/tests/tests_core/domain/use_cases/add_new_test_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'take_test_cubit_state.dart';

class TakeTestCubit extends Cubit<TakeTestCubitState> {
  TakeTestCubit(
    this._getTakeTestInfoUseCase,
    this._addNewTestUseCase,
    this._getDataSharedPrefUseCase,
  ) : super(TakeTestCubitState());

  final GetTakeTestInfoUseCase _getTakeTestInfoUseCase;

  final AddNewTestUseCase _addNewTestUseCase;

  final GetDataSharedPrefUseCase _getDataSharedPrefUseCase;

  Future<void> loadTakeTestData({required int testAppointmentID}) async {
    emit(state.copyWith(takeTestStatus: TakeTestStatus.loading));
    final result = await _getTakeTestInfoUseCase(testAppointmentID);
    result.fold(
      (failure) => emit(state.copyWith(takeTestStatus: TakeTestStatus.failure)),
      (takeTestInfoEntity) => emit(
        state.copyWith(
          takeTestStatus: TakeTestStatus.loaded,
          takeTestInfoEntity: takeTestInfoEntity,
          selectedResultTest:
              takeTestInfoEntity.testEntity?.testResult.value == 1
              ? true
              : false,
          notes: takeTestInfoEntity.testEntity?.notes,
        ),
      ),
    );
  }

  Future<void> saveTakeTest() async {
    emit(state.copyWith(takeTestStatus: TakeTestStatus.loading));

    final createdByUserId = await _getDataSharedPrefUseCase(
      stringKey: sharedPrefKeyCurrentUser,
    );

    if (createdByUserId == null) {
      emit(
        state.copyWith(
          takeTestStatus: TakeTestStatus.failure,
          errorMessage: "User not found",
        ),
      );
      return;
    }

    final testEntity = TestEntity(
      testAppointmentId:
          state.takeTestInfoEntity!.testAppointmentEntity.testAppointmentID!,
      testResult: state.selectedResultTest ? TestResult.pass : TestResult.fail,
      notes: state.notes ?? "",
      createdByUserId: createdByUserId.userId!,
    );

    final result = await _addNewTestUseCase.call(testEntity);
    result.fold(
      (failure) => emit(
        state.copyWith(
          takeTestStatus: TakeTestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(takeTestStatus: TakeTestStatus.success, isLucked: true),
      ),
    );
  }

  void onChangeRadioOption(bool selectedOption) {
    emit(state.copyWith(selectedResultTest: selectedOption));
  }

  void onChangeNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }
}
