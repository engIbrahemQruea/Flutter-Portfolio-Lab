part of 'person_selector_cubit.dart';

enum EnRequestStatus { initial, loading, success, failure }

class PersonSelectorCubitState extends Equatable {
  const PersonSelectorCubitState({
    this.filterTypeOption = EnFilterTypeOption.personID,
    this.filterInputValue,
    this.countryName,
    this.personEntity,
    this.errorMessage,
    this.searchStatus = EnRequestStatus.initial,
  });

  final EnFilterTypeOption filterTypeOption;
  final String? filterInputValue;
  final String? countryName;
  final PeopleEntity? personEntity;
  final EnRequestStatus searchStatus;
  final String? errorMessage;

  PersonSelectorCubitState copyWith({
    EnFilterTypeOption? filterTypeOption,
    String? filterInputValue,
    String? countryName,
    PeopleEntity? Function()? personEntity,
    EnRequestStatus? searchStatus,
    String? Function()? errorMessage,
  }) {
    return PersonSelectorCubitState(
      filterTypeOption: filterTypeOption ?? this.filterTypeOption,
      filterInputValue: filterInputValue ?? this.filterInputValue,
      countryName: countryName ?? this.countryName,
      personEntity: personEntity != null ? personEntity() : this.personEntity,
      searchStatus: searchStatus ?? this.searchStatus,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    filterTypeOption,
    filterInputValue,
    countryName,
    personEntity,
    searchStatus,
    errorMessage,
  ];
}
