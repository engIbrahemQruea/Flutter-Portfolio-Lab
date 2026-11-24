part of 'person_license_history_screen_cubit.dart';

sealed class PersonLicenseHistoryScreenCubitState extends Equatable {
  const PersonLicenseHistoryScreenCubitState();

  @override
  List<Object> get props => [];
}

final class PersonLicenseHistoryScreenCubitInitial
    extends PersonLicenseHistoryScreenCubitState {}

final class PersonLicenseHistoryScreenCubitLoading
    extends PersonLicenseHistoryScreenCubitState {}

final class PersonNoSelectedLicenseHistoryScreenCubit
    extends PersonLicenseHistoryScreenCubitState {}

final class PersonSelectedLicenseHistoryScreenCubit
    extends PersonLicenseHistoryScreenCubitState {
  final int personId;
  const PersonSelectedLicenseHistoryScreenCubit({required this.personId});
}
