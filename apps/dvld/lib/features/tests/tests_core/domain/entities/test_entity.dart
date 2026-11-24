import 'package:dvld/features/tests/tests_core/domain/entities/test_result_status.dart';
import 'package:equatable/equatable.dart';

class TestEntity extends Equatable {
  final int? testID;
  final int testAppointmentId;
  final TestResult testResult;
  final String? notes;
  final int createdByUserId;

  const TestEntity({
    this.testID,
    required this.testAppointmentId,
    required this.testResult,
    this.notes,
    required this.createdByUserId,
  });

  @override
  List<Object?> get props => [
    testID,
    testAppointmentId,
    testResult,
    notes,
    createdByUserId,
  ];
}
