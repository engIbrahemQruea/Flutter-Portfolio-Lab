import 'package:bloc/bloc.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_national_no_use_case.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/enums/filter_type.dart';
import 'package:equatable/equatable.dart';

part 'person_selector_cubit_state.dart';

class PersonSelectorCubit extends Cubit<PersonSelectorCubitState> {
  PersonSelectorCubit(
    this._getInfoByIdUseCase,
    this._getInfoByNationalNoUseCase,
  ) : super(PersonSelectorCubitState(searchStatus: EnRequestStatus.initial));

  final GetInfoByIdUseCase _getInfoByIdUseCase;
  final GetInfoByNationalNoUseCase _getInfoByNationalNoUseCase;

  void onSelectedFilterType(String filterType) {
    switch (filterType) {
      case 'personID':
        emit(state.copyWith(filterType: EnFilterType.personID));
        break;
      case 'nationalNo':
        emit(state.copyWith(filterType: EnFilterType.nationalNo));
        break;
    }
  }

  void onChangedFilterValue(String filterValue) {
    emit(state.copyWith(filterInputValue: filterValue));
  }

  void onSearch() async {
    if (state.filterType == EnFilterType.personID) {
      await getInfoPersonByID(personID: int.parse(state.filterInputValue!));
    } else {
      await getInfoPersonByNationalNo(nationalNo: state.filterInputValue!);
    }
  }

  Future<void> getInfoPersonByID({required int personID}) async {
    emit(state.copyWith(searchStatus: EnRequestStatus.loading));

    final result = await _getInfoByIdUseCase.call(personID);

    result.fold(
      (failure) => emit(
        state.copyWith(
          searchStatus: EnRequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (person) => emit(
        state.copyWith(
          searchStatus: EnRequestStatus.success,
          personEntity: person,
        ),
      ),
    );
  }

  Future<void> getInfoPersonByNationalNo({required String nationalNo}) async {
    emit(state.copyWith(searchStatus: EnRequestStatus.loading));

    final result = await _getInfoByNationalNoUseCase.call(nationalNo);

    result.fold(
      (failure) => emit(
        state.copyWith(
          searchStatus: EnRequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (person) => emit(
        state.copyWith(
          searchStatus: EnRequestStatus.success,
          personEntity: person,
        ),
      ),
    );
  }
}
