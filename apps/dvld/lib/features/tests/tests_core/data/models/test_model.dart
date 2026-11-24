import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/tests/tests_core/data/data_sources/test_table.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_entity.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_result_status.dart';
import 'package:flutter/foundation.dart';

@immutable
final class TestModel extends DataMapper<TestEntity> {
  final int? testID;
  final int testAppointmentId;
  final TestResult testResult;
  final String? notes;
  final int createdByUserId;

  const TestModel({
    this.testID,
    required this.testAppointmentId,
    required this.testResult,
    this.notes,
    required this.createdByUserId,
  });

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      testID: map[TestTable.colId] as int?,
      testAppointmentId: map[TestTable.colAppointmentId] as int,
      testResult: TestResult.fromValue(map[TestTable.colResult] as int),
      notes: map[TestTable.colNotes] as String?,
      createdByUserId: map[TestTable.colCreatedByUserId] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (testID != null) TestTable.colId: testID,
      TestTable.colAppointmentId: testAppointmentId,
      TestTable.colResult: testResult.value,
      TestTable.colNotes: notes,
      TestTable.colCreatedByUserId: createdByUserId,
    };
  }

  factory TestModel.fromEntity(TestEntity entity) {
    return TestModel(
      testID: entity.testID,
      testAppointmentId: entity.testAppointmentId,
      testResult: entity.testResult,
      notes: entity.notes,
      createdByUserId: entity.createdByUserId,
    );
  }

  @override
  TestEntity mapToEntity() {
    return TestEntity(
      testID: testID,
      testAppointmentId: testAppointmentId,
      testResult: testResult,
      notes: notes,
      createdByUserId: createdByUserId,
    );
  }

  TestModel copyWith({
    int? testID,
    int? testAppointmentId,
    TestResult? testResult,
    String? notes,
    int? createdByUserId,
  }) {
    return TestModel(
      testID: testID ?? this.testID,
      testAppointmentId: testAppointmentId ?? this.testAppointmentId,
      testResult: testResult ?? this.testResult,
      notes: notes ?? this.notes,
      createdByUserId: createdByUserId ?? this.createdByUserId,
    );
  }
}
