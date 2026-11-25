part of 'show_license_info_cubit.dart';

sealed class ShowLicenseInfoCubitState extends Equatable {
  const ShowLicenseInfoCubitState();

  @override
  List<Object> get props => [];
}

final class ShowLicenseInfoCubitInitial extends ShowLicenseInfoCubitState {}

final class ShowLicenseInfoCubitLoading extends ShowLicenseInfoCubitState {}

final class ShowLicenseInfoCubitLoaded extends ShowLicenseInfoCubitState {
  final LicenseDetailsEntity licenseDetailsEntity;
  const ShowLicenseInfoCubitLoaded(this.licenseDetailsEntity);
}

final class ShowLicenseInfoCubitFailure extends ShowLicenseInfoCubitState {
  final String message;
  const ShowLicenseInfoCubitFailure(this.message);
}
