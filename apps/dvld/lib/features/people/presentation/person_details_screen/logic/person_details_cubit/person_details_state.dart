part of 'person_details_cubit.dart';

sealed class PersonDetailsState extends Equatable {
  const PersonDetailsState();

  @override
  List<Object> get props => [];
}

final class PersonDetailsInitial extends PersonDetailsState {}

final class PersonDetailsLoading extends PersonDetailsState {}

final class PersonDetailsSuccess extends PersonDetailsState {
  final PeopleEntity? peopleEntity;
  const PersonDetailsSuccess(this.peopleEntity);
}

final class PersonDetailsFailure extends PersonDetailsState {
  final String errorMessage;
  const PersonDetailsFailure(this.errorMessage);
}
