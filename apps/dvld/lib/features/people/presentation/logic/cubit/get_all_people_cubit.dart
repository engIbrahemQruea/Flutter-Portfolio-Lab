// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/usecases/get_list_people_use_case.dart';
import 'package:meta/meta.dart';

part 'get_all_people_state.dart';

class GetAllPeopleCubit extends Cubit<GetAllPeopleState> {
  GetAllPeopleCubit(this._getListPeopleUseCase) : super(GetAllPeopleInitial());
  final GetListPeopleUseCase _getListPeopleUseCase;
  Future<void> getAllPeople() async {
    emit(GetAllPeopleLoading());
    final result = await _getListPeopleUseCase.call();
    result.fold(
      (failure) => emit(GetAllPeopleFailure('Failed to fetch people')),
      (people) => emit(GetAllPeopleSuccess(people)),
    );
  }
}
