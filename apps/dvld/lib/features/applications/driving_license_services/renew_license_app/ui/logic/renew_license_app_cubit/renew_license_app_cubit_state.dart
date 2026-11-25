part of 'renew_license_app_cubit.dart';

sealed class RenewLicenseAppCubitState extends Equatable {
  const RenewLicenseAppCubitState();

  @override
  List<Object?> get props => [];
}

final class RenewLicenseAppCubitInitial extends RenewLicenseAppCubitState {}

final class RenewLicenseAppCubitLoading extends RenewLicenseAppCubitState {}

final class RenewLicenseAppCubitLoaded extends RenewLicenseAppCubitState {
  final RenewLicenseEntity renewLicenseEntity;
  final String? errorMessage;
  final bool canRenew;
  final bool showLicenseInfo;
  final bool showLicenseInfoHistory;

  const RenewLicenseAppCubitLoaded({
    required this.renewLicenseEntity,
    this.errorMessage,
    this.canRenew = false,
    this.showLicenseInfo = false,
    this.showLicenseInfoHistory = false,
  });

  RenewLicenseAppCubitLoaded copyWith({
    RenewLicenseEntity? renewLicenseEntity,
    String? errorMessage,
    bool? canRenew,
    bool? showLicenseInfo,
    bool? showLicenseInfoHistory,
  }) => RenewLicenseAppCubitLoaded(
    renewLicenseEntity: renewLicenseEntity ?? this.renewLicenseEntity,
    errorMessage: errorMessage ?? this.errorMessage,
    canRenew: canRenew ?? this.canRenew,
    showLicenseInfo: showLicenseInfo ?? this.showLicenseInfo,
    showLicenseInfoHistory:
        showLicenseInfoHistory ?? this.showLicenseInfoHistory,
  );

  @override
  List<Object?> get props => [
    renewLicenseEntity,
    errorMessage,
    canRenew,
    showLicenseInfo,
    showLicenseInfoHistory,
  ];
}

final class RenewLicenseAppCubitSuccess extends RenewLicenseAppCubitState {
  final RenewLicenseAppCubitLoaded renewLicensePrevious;
  final bool filterWidgetEnable;

  const RenewLicenseAppCubitSuccess({
    required this.renewLicensePrevious,
    this.filterWidgetEnable = true,
  });
}

final class RenewLicenseAppCubitFailure extends RenewLicenseAppCubitState {
  final String errorMessage;

  const RenewLicenseAppCubitFailure({required this.errorMessage});
}
