part of 'driver_license_info_with_filter_cubit.dart';

sealed class DriverLicenseInfoWithFilterCubitState extends Equatable {
  const DriverLicenseInfoWithFilterCubitState();

  @override
  List<Object> get props => [];
}

final class DriverLicenseInfoWithFilterCubitInitial
    extends DriverLicenseInfoWithFilterCubitState {}

final class DriverLicenseInfoWithFilterCubitLoading
    extends DriverLicenseInfoWithFilterCubitState {}

final class DriverLicenseInfoWithFilterCubitLoaded
    extends DriverLicenseInfoWithFilterCubitState {
  final int licenseId;
  final LicenseDetailsEntity licenseInfoDetails;
  const DriverLicenseInfoWithFilterCubitLoaded(
    this.licenseId, {
    required this.licenseInfoDetails,
  });
}

final class DriverLicenseInfoWithFilterCubitFailure
    extends DriverLicenseInfoWithFilterCubitState {
  final String errorMessage;
  const DriverLicenseInfoWithFilterCubitFailure({required this.errorMessage});
}
