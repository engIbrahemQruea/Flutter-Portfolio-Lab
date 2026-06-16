part of 'get_all_people_cubit.dart';

@immutable
sealed class GetAllPeopleState {}

final class GetAllPeopleInitial extends GetAllPeopleState {}

final class GetAllPeopleLoading extends GetAllPeopleState {}

final class GetAllPeopleSuccess extends GetAllPeopleState {
  final List<PeopleEntity?> people;

  GetAllPeopleSuccess(this.people);
}

final class GetAllPeopleFailure extends GetAllPeopleState {
  final String errMessage;

  GetAllPeopleFailure(this.errMessage);
}
