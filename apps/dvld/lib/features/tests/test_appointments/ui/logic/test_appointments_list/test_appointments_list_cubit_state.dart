part of 'test_appointments_list_cubit.dart';


enum CanPrescheduleTestStatus { initial, loading, success, failure;
bool get isInitial => this == CanPrescheduleTestStatus.initial;
  bool get isLoading => this == CanPrescheduleTestStatus.loading;
  bool get isSuccess => this == CanPrescheduleTestStatus.success;
  bool get isFailure => this == CanPrescheduleTestStatus.failure;
 }
final class TestAppointmentsListCubitState extends Equatable {
  const TestAppointmentsListCubitState({
    this.testAppointmentState = RequestStatus.initial,
    this.testAppointmentItems = const [],
    this.testAppointments = const [],
    this.canPrescheduleTestStatus = CanPrescheduleTestStatus.initial,
    this.errorMessageCanPrescheduleTest,
    this.errorMessage,
  });

  final RequestStatus testAppointmentState;
  final List<TestAppointmentItemEntity>? testAppointmentItems;
  final List<TestAppointmentEntity>? testAppointments;
  final CanPrescheduleTestStatus canPrescheduleTestStatus;
  final String? errorMessageCanPrescheduleTest;
  final String? errorMessage;

  TestAppointmentsListCubitState copyWith({
    RequestStatus? testAppointmentState,
    List<TestAppointmentItemEntity>? testAppointmentItems,
    List<TestAppointmentEntity>? testAppointments,
    CanPrescheduleTestStatus? canPrescheduleTestStatus,
    ValueGetter<String?>? errorMessage,
    ValueGetter<String?>? errorMessageCanPrescheduleTest,
  }) {
    return TestAppointmentsListCubitState(
      testAppointmentState: testAppointmentState ?? this.testAppointmentState,
      testAppointmentItems: testAppointmentItems ?? this.testAppointmentItems,
      testAppointments: testAppointments ?? this.testAppointments,
      canPrescheduleTestStatus: canPrescheduleTestStatus ?? this.canPrescheduleTestStatus,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      errorMessageCanPrescheduleTest: errorMessageCanPrescheduleTest != null ? errorMessageCanPrescheduleTest() : this.errorMessageCanPrescheduleTest,
    );
  }

  @override
  List<Object?> get props => [
    testAppointmentState,
    testAppointmentItems,
    testAppointments,
    canPrescheduleTestStatus,
    errorMessage,
    errorMessageCanPrescheduleTest,
  ];
}
