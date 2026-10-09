part of 'schedule_test_cubit.dart';

sealed class ScheduleTestCubitState extends Equatable {
  const ScheduleTestCubitState();
  @override
  List<Object?> get props => [];
}

class ScheduleTestInitial extends ScheduleTestCubitState {}

class ScheduleTestLoading extends ScheduleTestCubitState {}

class ScheduleTestLoaded extends ScheduleTestCubitState {
  final ScheduleTestInfoEntity info;
  final DateTime selectedDate;

  const ScheduleTestLoaded({required this.info, required this.selectedDate});

  ScheduleTestLoaded copyWith({
    DateTime? selectedDate,
    ScheduleTestInfoEntity? info,
  }) {
    return ScheduleTestLoaded(
      info: info ?? this.info,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [info, selectedDate];
}

class ScheduleTestSubmitting extends ScheduleTestCubitState {}

class ScheduleTestSuccess extends ScheduleTestCubitState {
  final String message;
  const ScheduleTestSuccess(this.message);
}

class ScheduleTestFailure extends ScheduleTestCubitState {
  final String errorMessage;
  const ScheduleTestFailure(this.errorMessage);
}
