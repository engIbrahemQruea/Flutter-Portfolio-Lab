// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/usecases/delete_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_list_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_first_name_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_id_use_case.dart'
    show GetPeopleByIdUseCase;
import 'package:dvld/features/people/domain/usecases/get_people_by_national_no_use_case.dart';
import 'package:meta/meta.dart';

part 'get_all_people_state.dart';

class GetAllPeopleCubit extends Cubit<GetAllPeopleState> {
  GetAllPeopleCubit(
    this._getListPeopleUseCase,
    this._getPeopleByIdUseCase,
    this._getPeopleByNationalNoUseCase,
    this._getPeopleByFirstNameUseCase,
    this._deletePeopleUseCase,
  ) : super(GetAllPeopleInitial()) {
    getAllPeople();
  }
  final GetListPeopleUseCase _getListPeopleUseCase;
  final GetPeopleByIdUseCase _getPeopleByIdUseCase;
  final GetPeopleByNationalNoUseCase _getPeopleByNationalNoUseCase;
  final GetPeopleByFirstNameUseCase _getPeopleByFirstNameUseCase;
  final DeletePeopleUseCase _deletePeopleUseCase;

  Future<void> getAllPeople() async {
    emit(GetAllPeopleLoading());
    final result = await _getListPeopleUseCase.call();
    result.fold(
      (failure) => emit(GetAllPeopleFailure('Failed to fetch people')),
      (people) => emit(GetAllPeopleSuccess(people)),
    );
  }

  Future<void> getPeopleById({required int personID}) async {
    emit(GetAllPeopleLoading());
    final result = await _getPeopleByIdUseCase.call(personID);
    result.fold(
      (failure) => emit(GetAllPeopleFailure('No Value Found in PersonID')),
      (peopleID) => emit(GetAllPeopleSuccess(peopleID)),
    );
  }

  Future<void> getPeopleByNationalNo({required String nationalNo}) async {
    emit(GetAllPeopleLoading());
    final result = await _getPeopleByNationalNoUseCase.call(nationalNo);
    result.fold(
      (failure) => emit(GetAllPeopleFailure('No Value Found in National No')),
      (peopleNation) => emit(GetAllPeopleSuccess(peopleNation)),
    );
  }

  Future<void> getPeopleByFirstName({required String firstName}) async {
    emit(GetAllPeopleLoading());
    final result = await _getPeopleByFirstNameUseCase.call(firstName);
    result.fold(
      (failure) => emit(GetAllPeopleFailure('No Value Found in First Name')),
      (peopleName) => emit(GetAllPeopleSuccess(peopleName)),
    );
  }

  Future<void> deletePeople({required int personID}) async {
    emit(DeletePeopleLoading());
    final result = await _deletePeopleUseCase.call(personID);
    result.fold(
      (failure) => emit(DeletePeopleFailure(failure.message)),
      (success) => emit(DeletePeopleSuccess()),
    );
  }
}
