part of 'show_international_license_info_cubit.dart';

sealed class ShowInternationalLicenseInfoCubitState extends Equatable {
  const ShowInternationalLicenseInfoCubitState();

  @override
  List<Object> get props => [];
}

final class ShowInternationalLicenseInfoCubitInitial
    extends ShowInternationalLicenseInfoCubitState {}

final class ShowInternationalLicenseInfoCubitLoading
    extends ShowInternationalLicenseInfoCubitState {}

final class ShowInternationalLicenseInfoCubitLoaded
    extends ShowInternationalLicenseInfoCubitState {
  final InternationalLicenseDetailsReadEntity
  internationalLicenseDetailsReadEntity;

  const ShowInternationalLicenseInfoCubitLoaded({
    required this.internationalLicenseDetailsReadEntity,
  });

  @override
  List<Object> get props => [internationalLicenseDetailsReadEntity];
}

final class ShowInternationalLicenseInfoCubitFailure
    extends ShowInternationalLicenseInfoCubitState {
  final String message;

  const ShowInternationalLicenseInfoCubitFailure({required this.message});

  @override
  List<Object> get props => [message];
}
