import 'package:dvld/core/helpers/type_def.dart';
import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/applications/test_types/data/data_sources/test_type_table.dart';
import 'package:dvld/features/applications/test_types/domain/entities/test_type_entity.dart';
import 'package:equatable/equatable.dart';

class TestTypeModel extends DataMapper<TestTypeEntity> with Equatable {
  const TestTypeModel({
    required this.testTypeId,
    required this.testTypeTitle,
    required this.testTypeDescription,
    required this.testTypeFees,
  });

  final int? testTypeId;
  final String testTypeTitle;
  final String testTypeDescription;
  final double testTypeFees;

  factory TestTypeModel.fromMap(Map<String, dynamic> map) {
    return TestTypeModel(
      testTypeId: map[TestTypeTable.colId],
      testTypeTitle: map[TestTypeTable.colTitle],
      testTypeDescription: map[TestTypeTable.colDescription],
      testTypeFees: (map[TestTypeTable.colFees] as num).toDouble(),
    );
  }

  JsonMap toMap() => {
    if (testTypeId != null) TestTypeTable.colId: testTypeId,
    TestTypeTable.colTitle: testTypeTitle,
    TestTypeTable.colDescription: testTypeDescription,
    TestTypeTable.colFees: testTypeFees,
  };

  factory TestTypeModel.fromEntity(TestTypeEntity entity) => TestTypeModel(
    testTypeId: entity.testTypeId,
    testTypeTitle: entity.testTypeTitle,
    testTypeDescription: entity.testTypeDescription,
    testTypeFees: entity.testTypeFees,
  );

  @override
  TestTypeEntity mapToEntity() => TestTypeEntity(
    testTypeId: testTypeId,
    testTypeTitle: testTypeTitle,
    testTypeDescription: testTypeDescription,
    testTypeFees: testTypeFees,
  );

  @override
  List<Object?> get props => [
    testTypeId,
    testTypeTitle,
    testTypeDescription,
    testTypeFees,
  ];
}
