import 'package:equatable/equatable.dart';

class TestTypeEntity extends Equatable {
  const TestTypeEntity({
    this.testTypeId,
    required this.testTypeTitle,
    required this.testTypeDescription,
    required this.testTypeFees,
  });

  final int? testTypeId;
  final String testTypeTitle;
  final String testTypeDescription;
  final double testTypeFees;

  factory TestTypeEntity.empty() => const TestTypeEntity(
    testTypeId: null,
    testTypeTitle: '',
    testTypeDescription: '',
    testTypeFees: 0,
  );

  @override
  List<Object?> get props => [
    testTypeId,
    testTypeTitle,
    testTypeDescription,
    testTypeFees,
  ];
}
