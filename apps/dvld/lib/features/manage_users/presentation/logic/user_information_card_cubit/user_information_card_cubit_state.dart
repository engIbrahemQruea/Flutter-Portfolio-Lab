part of 'user_information_card_cubit.dart';

final class UserInformationCardCubitState extends Equatable {
  const UserInformationCardCubitState({
    this.userInformationCardStatus = RequestStatus.initial,
    this.userEntity,
    this.peopleEntity,
    this.countryName,
    this.errorMessage,
  });

  final RequestStatus userInformationCardStatus;
  final UserEntity? userEntity;
  final PeopleEntity? peopleEntity;
  final String? countryName;
  final String? errorMessage;

  UserInformationCardCubitState copyWith({
    RequestStatus Function()? showDetailsUserScreenStatus,
    UserEntity? Function()? userEntity,
    PeopleEntity? Function()? peopleEntity,
    String? Function()? countryName,
    String? Function()? errorMessage,
  }) {
    return UserInformationCardCubitState(
      userInformationCardStatus: showDetailsUserScreenStatus != null
          ? showDetailsUserScreenStatus()
          : this.userInformationCardStatus,
      userEntity: userEntity != null ? userEntity() : this.userEntity,
      peopleEntity: peopleEntity != null ? peopleEntity() : this.peopleEntity,
      countryName: countryName != null ? countryName() : this.countryName,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    userInformationCardStatus,
    userEntity,
    peopleEntity,
    countryName,
    errorMessage,
  ];
}
