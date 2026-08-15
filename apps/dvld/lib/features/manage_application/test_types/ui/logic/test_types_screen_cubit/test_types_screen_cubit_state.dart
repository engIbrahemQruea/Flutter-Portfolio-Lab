part of 'test_types_screen_cubit.dart';

sealed class TestTypesScreenCubitState extends Equatable {
  const TestTypesScreenCubitState();

  @override
  List<Object> get props => [];
}

final class TestTypesScreenCubitInitial extends TestTypesScreenCubitState {}

final class TestTypesScreenCubitLoading extends TestTypesScreenCubitState {}

final class TestTypesScreenCubitSuccess extends TestTypesScreenCubitState {
  final List<TestTypeEntity> testTypesList;
  const TestTypesScreenCubitSuccess(this.testTypesList);

  @override
  List<Object> get props => [testTypesList];
}

final class TestTypesScreenCubitFailure extends TestTypesScreenCubitState {
  final String errorMessage;
  const TestTypesScreenCubitFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
