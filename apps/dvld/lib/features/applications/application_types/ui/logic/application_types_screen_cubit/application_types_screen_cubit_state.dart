part of 'application_types_screen_cubit.dart';

sealed class ApplicationTypesScreenCubitState extends Equatable {
  const ApplicationTypesScreenCubitState();

  @override
  List<Object> get props => [];
}

final class ApplicationTypesScreenCubitInitial
    extends ApplicationTypesScreenCubitState {}

final class ApplicationTypesScreenCubitLoading
    extends ApplicationTypesScreenCubitState {}

final class ApplicationTypesScreenCubitSuccess
    extends ApplicationTypesScreenCubitState {
  final List<ApplicationTypeEntity> applicationTypesList;

  const ApplicationTypesScreenCubitSuccess({
    required this.applicationTypesList,
  });

  @override
  List<Object> get props => [applicationTypesList];
}

final class ApplicationTypesScreenCubitFailure
    extends ApplicationTypesScreenCubitState {
  final String errorMessage;

  const ApplicationTypesScreenCubitFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
