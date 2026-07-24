part of 'person_selector_cubit.dart';

enum EnRequestStatus { initial, loading, success, failure }

class PersonSelectorCubitState extends Equatable {
  const PersonSelectorCubitState({
    this.filterType = EnFilterType.personID,
    this.filterInputValue,
    this.personEntity,
    this.errorMessage,
    this.searchStatus = EnRequestStatus.initial,
  });

  //   factory PersonSelectorCubitState.initial() => const PersonSelectorCubitState(
  //  filterType: EnFilterType.personID,
  //  filterValue: '',

  //   );

  final EnFilterType filterType;

  final String? filterInputValue;

  final PeopleEntity? personEntity;

  final EnRequestStatus searchStatus;

  final String? errorMessage;

  PersonSelectorCubitState copyWith({
    EnFilterType? filterType,
    String? filterInputValue,
    PeopleEntity? personEntity,
    EnRequestStatus? searchStatus,
    String? Function()? errorMessage,
  }) {
    return PersonSelectorCubitState(
      filterType: filterType ?? this.filterType,
      filterInputValue: filterInputValue ?? this.filterInputValue,
      personEntity: personEntity ?? this.personEntity,
      searchStatus: searchStatus ?? this.searchStatus,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object> get props => [];
}
