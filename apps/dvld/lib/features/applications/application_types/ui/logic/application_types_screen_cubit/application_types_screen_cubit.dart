import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'application_types_screen_cubit_state.dart';

class ApplicationTypesScreenCubit
    extends Cubit<ApplicationTypesScreenCubitState> {
  ApplicationTypesScreenCubit(this._getAllApplicationTypesUseCase)
    : super(ApplicationTypesScreenCubitInitial());

  final GetAllApplicationTypesUseCase _getAllApplicationTypesUseCase;

  Future<void> getAllApplicationTypes() async {
    emit(ApplicationTypesScreenCubitLoading());
    final result = await _getAllApplicationTypesUseCase.call();
    result.fold(
      (l) => emit(ApplicationTypesScreenCubitFailure(errorMessage: l.message)),
      (r) => emit(ApplicationTypesScreenCubitSuccess(applicationTypesList: r)),
    );
  }
}
