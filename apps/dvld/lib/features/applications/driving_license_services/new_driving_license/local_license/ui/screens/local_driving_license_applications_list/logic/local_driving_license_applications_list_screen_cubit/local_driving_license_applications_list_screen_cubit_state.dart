part of 'local_driving_license_applications_list_screen_cubit.dart';

final class LocalDrivingLicenseApplicationsListScreenCubitState
    extends Equatable {
  const LocalDrivingLicenseApplicationsListScreenCubitState({
    this.loadLocalAppStatus = RequestStatus.initial,
    this.applicationsList = const [],
    this.filteredApplicationsList = const [],
    this.permissionsMenu,
    this.localAppFilterType = LocalApplicationFilterType.none,
    this.filterValue = '',
    this.errorMessage,
  });

  final RequestStatus loadLocalAppStatus;

  final List<LocalDrivingLicenseApplicationListItemEntity> applicationsList;

  final List<LocalDrivingLicenseApplicationListItemEntity>
  filteredApplicationsList;

  final LocalApplicationMenuPermissionsEntity? permissionsMenu;

  final LocalApplicationFilterType localAppFilterType;

  final String filterValue;

  final String? errorMessage;

  bool get hasNoFiltered =>
      localAppFilterType == LocalApplicationFilterType.none;

  LocalDrivingLicenseApplicationsListScreenCubitState copyWith({
    RequestStatus? loadLocalAppStatus,
    List<LocalDrivingLicenseApplicationListItemEntity>? applicationsList,
    List<LocalDrivingLicenseApplicationListItemEntity>?
    filteredApplicationsList,
    LocalApplicationMenuPermissionsEntity? permissionsMenu,
    LocalApplicationFilterType? localAppFilterType,
    ValueGetter<String>? filterValue,
    ValueGetter<String?>? errorMessage,
  }) {
    return LocalDrivingLicenseApplicationsListScreenCubitState(
      loadLocalAppStatus: loadLocalAppStatus ?? this.loadLocalAppStatus,
      applicationsList: applicationsList ?? this.applicationsList,
      filteredApplicationsList:
          filteredApplicationsList ?? this.filteredApplicationsList,
      permissionsMenu: permissionsMenu ?? this.permissionsMenu,
      localAppFilterType: localAppFilterType ?? this.localAppFilterType,
      filterValue: filterValue != null ? filterValue() : this.filterValue,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loadLocalAppStatus,
    applicationsList,
    filteredApplicationsList,
    permissionsMenu,
    localAppFilterType,
    filterValue,
    errorMessage,
  ];
}
