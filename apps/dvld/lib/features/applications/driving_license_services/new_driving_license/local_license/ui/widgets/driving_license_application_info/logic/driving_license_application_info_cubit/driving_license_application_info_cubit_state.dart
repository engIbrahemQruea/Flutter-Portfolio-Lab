part of 'driving_license_application_info_cubit.dart';

final class DrivingLicenseApplicationInfoCubitState extends Equatable {
  const DrivingLicenseApplicationInfoCubitState({
    this.drivingLicenseAppInfoStatus = RequestStatus.initial,
    this.localDrLiApplicationDetailsReadEntity,
    this.errorMessage,
  });

  final RequestStatus drivingLicenseAppInfoStatus;
  final LocalDrivingLicenseApplicationDetailsReadEntity?
  localDrLiApplicationDetailsReadEntity;
  final String? errorMessage;

  // bool get hasActiveLicense =>
  //     localDrLiApplicationEntity?.licenseClassEntity != null;

  DrivingLicenseApplicationInfoCubitState copyWith({
    RequestStatus? drivingLicenseAppInfoStatus,
    LocalDrivingLicenseApplicationDetailsReadEntity?
    localDrLiApplicationDetailsReadEntity,
    ValueGetter<String?>? errorMessage,
  }) => DrivingLicenseApplicationInfoCubitState(
    drivingLicenseAppInfoStatus:
        drivingLicenseAppInfoStatus ?? this.drivingLicenseAppInfoStatus,
    localDrLiApplicationDetailsReadEntity:
        localDrLiApplicationDetailsReadEntity ??
        this.localDrLiApplicationDetailsReadEntity,
    errorMessage: errorMessage == null ? this.errorMessage : errorMessage(),
  );

  @override
  List<Object?> get props => [
    drivingLicenseAppInfoStatus,
    localDrLiApplicationDetailsReadEntity,
    errorMessage,
  ];
}
