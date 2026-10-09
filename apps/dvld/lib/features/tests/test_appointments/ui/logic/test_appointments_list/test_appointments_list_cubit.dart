import 'package:dvld/core/helpers/forms/forms.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/read_entities/test_appointment_item_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/use_cases/can_preschedule_test_use_case.dart';
import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'test_appointments_list_cubit_state.dart';

class TestAppointmentsListCubit extends Cubit<TestAppointmentsListCubitState> {
  TestAppointmentsListCubit(
    this._getAllTestAppointmentsUseCase,
    this._getApplicationTestAppointmentsPerTestTypeUseCase,
    this._canPrescheduleTestUseCase,
  ) : super(TestAppointmentsListCubitState());

  final GetAllTestAppointmentsUseCase _getAllTestAppointmentsUseCase;

  final GetApplicationTestAppointmentsPerTestTypeUseCase
  _getApplicationTestAppointmentsPerTestTypeUseCase;

  final CanPrescheduleTestUseCase _canPrescheduleTestUseCase;

  Future<void> getAllTestAppointments() async {
    emit(state.copyWith(testAppointmentState: RequestStatus.loading));
    final result = await _getAllTestAppointmentsUseCase.call();
    result.fold(
      (failure) => emit(
        state.copyWith(
          testAppointmentState: RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (testAppointments) => emit(
        state.copyWith(
          testAppointmentState: RequestStatus.success,
          testAppointmentItems: testAppointments,
          errorMessage: () => null,
        ),
      ),
    );
  }

  Future<void> getTestAppointmentsPerTestType({
    required int localDLapplicationID,
    required int testTypeID,
  }) async {
    emit(state.copyWith(testAppointmentState: RequestStatus.loading));
    final result = await _getApplicationTestAppointmentsPerTestTypeUseCase.call(
      (localDLApplicationID: localDLapplicationID, testTypeID: testTypeID),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          testAppointmentState: RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (testAppointments) => emit(
        state.copyWith(
          testAppointmentState: RequestStatus.success,
          testAppointments: testAppointments,
          errorMessage: () => null,
        ),
      ),
    );
  }

  Future<void> canPrescheduleTest({
    required int testTypeId,
    required int localDlApplicationId,
  }) async {
    emit(state.copyWith(canPrescheduleTestStatus: CanPrescheduleTestStatus.loading));
    final result = await _canPrescheduleTestUseCase.call(
      testTypeId: testTypeId,
      localDlApplicationId: localDlApplicationId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          canPrescheduleTestStatus: CanPrescheduleTestStatus.failure,
          errorMessageCanPrescheduleTest: () => failure.message,
        ),
      ),
      (canPreschedule) => emit(
        state.copyWith(
          canPrescheduleTestStatus: CanPrescheduleTestStatus.success,
          errorMessageCanPrescheduleTest: () => null,
        ),
      ),
    );
  }
}
