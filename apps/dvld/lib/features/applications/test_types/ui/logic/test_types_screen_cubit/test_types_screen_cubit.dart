import 'package:bloc/bloc.dart';
import 'package:dvld/features/applications/test_types/domain/index_domain_test_type.dart';
import 'package:equatable/equatable.dart';

part 'test_types_screen_cubit_state.dart';

class TestTypesScreenCubit extends Cubit<TestTypesScreenCubitState> {
  TestTypesScreenCubit(this._getAllTestTypesUseCase)
    : super(TestTypesScreenCubitInitial());

  final GetAllTestTypesUseCase _getAllTestTypesUseCase;

  Future<void> getAllTestTypes() async {
    emit(TestTypesScreenCubitLoading());
    final result = await _getAllTestTypesUseCase.call();
    result.fold(
      (l) => emit(TestTypesScreenCubitFailure(l.message)),
      (r) => emit(TestTypesScreenCubitSuccess(r)),
    );
  }
}
