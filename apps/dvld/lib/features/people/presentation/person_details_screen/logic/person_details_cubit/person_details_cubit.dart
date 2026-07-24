// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dvld/features/people/data/repos_imp/people_repos_imp.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_id_use_case.dart';
import 'package:equatable/equatable.dart';

part 'person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  PersonDetailsCubit(this._getInfoByIdUseCase, this._peopleReposImp)
    : super(PersonDetailsInitial());

  final GetInfoByIdUseCase _getInfoByIdUseCase;
  final PeopleReposImp _peopleReposImp;

  late String countryName;

  Future<void> getInfoPersonDetailsById({required int personID}) async {
    emit(PersonDetailsLoading());
    final result = await _getInfoByIdUseCase.call(personID);
    result.fold((failure) => emit(PersonDetailsFailure(failure.message)), (
      success,
    ) async {
      await getNameCountryByIB(countryID: success!.nationalityCountryId);
      emit(PersonDetailsSuccess(success));
    });
  }

  Future<void> getNameCountryByIB({required int countryID}) async {
    final result = await _peopleReposImp.getCountryNameById(
      countryId: countryID,
    );

    return result.fold((l) => l.message, (r) => countryName = r.toString());
  }
}
