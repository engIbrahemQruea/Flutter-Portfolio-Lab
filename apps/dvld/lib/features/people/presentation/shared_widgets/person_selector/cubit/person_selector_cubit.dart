import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/usecases/get_country_name_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_national_no_use_case.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/enums/enum_filter_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'person_selector_cubit_state.dart';

class PersonSelectorCubit extends Cubit<PersonSelectorCubitState> {
  PersonSelectorCubit(
    this._getInfoByIdUseCase,
    this._getInfoByNationalNoUseCase,
    this._getCountryNameByIdUseCase,
  ) : super(PersonSelectorCubitState(searchStatus: EnRequestStatus.initial));

  final GetInfoByIdUseCase _getInfoByIdUseCase;
  final GetInfoByNationalNoUseCase _getInfoByNationalNoUseCase;
  final GetCountryNameByIdUseCase _getCountryNameByIdUseCase;

  void onSelectedFilterType(EnFilterTypeOption filterType) {
    emit(state.copyWith(filterTypeOption: filterType));
  }

  void onChangedFilterValue(String filterValue) {
    emit(state.copyWith(filterInputValue: filterValue));
  }

  Future<void> onPressedSearchButton() async {
    final input = state.filterInputValue?.trim();

    if (input == null || input.isEmpty) {
      emit(
        state.copyWith(
          searchStatus: EnRequestStatus.failure,
          errorMessage: () => 'Please enter search value',
        ),
      );
      return;
    }

    emit(state.copyWith(searchStatus: EnRequestStatus.loading));

    switch (state.filterTypeOption) {
      case EnFilterTypeOption.nationalNo:
        final result = await _getInfoByNationalNoUseCase.call(input);
        _handleResult(result);
        break;

      case EnFilterTypeOption.personID:
        final id = int.tryParse(input);
        if (id != null) {
          final result = await _getInfoByIdUseCase.call(id);
          _handleResult(result);
        } else {
          emit(
            state.copyWith(
              searchStatus: EnRequestStatus.failure,
              errorMessage: () => 'Invalid Person ID',
            ),
          );
        }
        break;
    }
  }

  Future<void> _handleResult(Either<Failure, PeopleEntity?> result) async {
    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            searchStatus: EnRequestStatus.failure,
            errorMessage: () => failure.message,
          ),
        );
      },

      (person) async {
        if (person == null) {
          emit(
            state.copyWith(
              searchStatus: EnRequestStatus.failure,
              errorMessage: () => 'This Person not found in database',
            ),
          );
          return;
        }

        final countryResult = await _getCountryNameByIdUseCase(
          person.nationalityCountryId,
        );

        countryResult.fold(
          (failure) {
            emit(
              state.copyWith(
                searchStatus: EnRequestStatus.failure,
                errorMessage: () => failure.message,
              ),
            );
          },

          (countryName) {
            emit(
              state.copyWith(
                searchStatus: EnRequestStatus.success,

                personEntity: () => person,

                countryName: countryName,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> getCountryNameByID(int countryID) async {
    final result = await _getCountryNameByIdUseCase.call(countryID);
    result.fold(
      (failure) => emit(
        state.copyWith(
          searchStatus: EnRequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (countryName) => emit(
        state.copyWith(
          searchStatus: EnRequestStatus.success,
          countryName: countryName,
        ),
      ),
    );
  }
}
