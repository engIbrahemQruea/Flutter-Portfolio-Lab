import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_type.dart';
import 'package:dvld/features/tests/schedule_test/domain/use_case/get_schedule_test_info_use_case.dart';
import 'package:dvld/features/tests/schedule_test/domain/use_case/save_schedule_test_info_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedule_test_cubit_state.dart';

class ScheduleTestCubit extends Cubit<ScheduleTestCubitState> {
  ScheduleTestCubit(this._loadInfoUseCase, this._saveAppointmentUseCase)
    : super(ScheduleTestInitial());

  final GetScheduleTestInfoUseCase _loadInfoUseCase;
  final SaveScheduleTestAppointmentUseCase _saveAppointmentUseCase;

  Future<void> loadData({
    required int localAppId,
    required ScheduleTestType testType,
    int? appointmentId,
  }) async {
    emit(ScheduleTestLoading());

    final result = await _loadInfoUseCase(
      LoadScheduleTestInfoParams(
        localDriLiceApplicationId: localAppId,
        testType: testType,
        testAppointmentID: appointmentId,
      ),
    );

    result.fold((failure) => emit(ScheduleTestFailure(failure.message)), (
      info,
    ) {
      final initialDate =
          info.testAppointment?.appointmentDate ?? DateTime.now();
      emit(ScheduleTestLoaded(info: info, selectedDate: initialDate));
    });
  }

  void updateSelectedDate(DateTime date) {
    if (state is ScheduleTestLoaded) {
      final current = state as ScheduleTestLoaded;
      emit(current.copyWith(selectedDate: date));
    }
  }

  Future<void> saveAppointment() async {
    if (state is! ScheduleTestLoaded) return;
    final current = state as ScheduleTestLoaded;

    emit(ScheduleTestSubmitting());

    final selectedDate = current.selectedDate;

    final createdParam = (
      localDLApplicationID: current
          .info
          .localApplicationDetailsReadEntity
          .localApplicationEntity
          .localDrLiAppId!,
      personID:
          current.info.localApplicationDetailsReadEntity.personEntity.personId!,
      testTypeID: current.info.testType!.testTypeId!,
      paidFees: current.info.retakeFees,
      testFees: current.info.testFees,
      currentUserId: current.info.currentUserId,
      selectedDate: selectedDate,
    );

    final saveResult = await _saveAppointmentUseCase.call(
      createdParam,
      current.info,
      selectedDate,
    );

    saveResult.fold(
      (failure) => emit(ScheduleTestFailure(failure.message)),
      (appointmentId) =>
          emit(const ScheduleTestSuccess("Data Saved Successfully.")),
    );
  }
}
