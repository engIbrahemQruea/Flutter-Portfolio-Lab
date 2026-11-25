part of 'replace_license_cubit.dart';

sealed class ReplaceLicenseCubitState extends Equatable {
  const ReplaceLicenseCubitState();

  @override
  List<Object?> get props => [];
}

final class ReplaceLicenseCubitInitial extends ReplaceLicenseCubitState {}

final class ReplaceLicenseCubitLoading extends ReplaceLicenseCubitState {}

final class ReplaceLicenseCubitNotLoaded extends ReplaceLicenseCubitState {
  final IssueReason selectedReason;
  final double applicationFees;

  const ReplaceLicenseCubitNotLoaded({
    required this.selectedReason,
    required this.applicationFees,
  });
}

final class ReplaceLicenseCubitLoaded extends ReplaceLicenseCubitState {
  final ReplaceLicenseEntity replaceLicenseEntity;
  final double applicationFees;
  final String? errorMessage;
  final bool canReplace;
  final bool showLicenseInfo;
  final bool showLicenseInfoHistory;
  final IssueReason selectedReason;

  const ReplaceLicenseCubitLoaded({
    required this.replaceLicenseEntity,
    required this.applicationFees,
    this.errorMessage,
    this.canReplace = false,
    this.showLicenseInfo = false,
    this.showLicenseInfoHistory = false,
    this.selectedReason = IssueReason.replacementForDamaged,
  });

  ReplaceLicenseCubitLoaded copyWith({
    ReplaceLicenseEntity? replaceLicenseEntity,
    final double? applicationFees,
    String? errorMessage,
    bool? canReplace,
    bool? showLicenseInfo,
    bool? showLicenseInfoHistory,
    IssueReason? selectedReason,
  }) => ReplaceLicenseCubitLoaded(
    replaceLicenseEntity: replaceLicenseEntity ?? this.replaceLicenseEntity,
    applicationFees: applicationFees ?? this.applicationFees,
    errorMessage: errorMessage ?? this.errorMessage,
    canReplace: canReplace ?? this.canReplace,
    showLicenseInfo: showLicenseInfo ?? this.showLicenseInfo,
    showLicenseInfoHistory:
        showLicenseInfoHistory ?? this.showLicenseInfoHistory,
    selectedReason: selectedReason ?? this.selectedReason,
  );

  @override
  List<Object?> get props => [
    replaceLicenseEntity,
    applicationFees,
    errorMessage,
    canReplace,
    showLicenseInfo,
    showLicenseInfoHistory,
    selectedReason,
  ];
}

final class ReplaceLicenseCubitSuccess extends ReplaceLicenseCubitState {
  final ReplaceLicenseCubitLoaded replaceLicensePrevious;
  final ReplaceLicenseResult replaceLicenseResult;
  final bool filterWidgetEnable;

  const ReplaceLicenseCubitSuccess({
    required this.replaceLicenseResult,
required this.replaceLicensePrevious,
    this.filterWidgetEnable = false,
  });
}

final class ReplaceLicenseCubitFailure extends ReplaceLicenseCubitState {
  final String errorMessage;
  const ReplaceLicenseCubitFailure({required this.errorMessage});
}
