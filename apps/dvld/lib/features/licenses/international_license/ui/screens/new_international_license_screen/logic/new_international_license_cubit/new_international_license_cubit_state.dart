part of 'new_international_license_cubit.dart';

sealed class NewInternationalLicenseCubitState extends Equatable {
  const NewInternationalLicenseCubitState();

  @override
  List<Object?> get props => [];
}

final class NewInternationalLicenseCubitInitial
    extends NewInternationalLicenseCubitState {}

final class NewInternationalLicenseCubitLoading
    extends NewInternationalLicenseCubitState {}

final class NewInternationalLicenseCubitEmpty
    extends NewInternationalLicenseCubitState {
  final NewInternationalLicenseReadEntity newInternationalLicenseReadEntity;

  const NewInternationalLicenseCubitEmpty({
    required this.newInternationalLicenseReadEntity,
  });

  @override
  List<Object?> get props => [newInternationalLicenseReadEntity];
}

final class NewInternationalLicenseCubitLoaded
    extends NewInternationalLicenseCubitState {
  final NewInternationalLicenseCubitEmpty? newInterLicePrevState;
  final int? licenseId;
  final int? internationalLicenseID;
  final String? message;
  final bool canIssue;

  const NewInternationalLicenseCubitLoaded({
    this.newInterLicePrevState,
    this.licenseId,
    this.internationalLicenseID,
    this.message,
    this.canIssue = false,
  });

  NewInternationalLicenseCubitLoaded copyWith({
    NewInternationalLicenseCubitEmpty? newInterLicePrevState,
    int? licenseId,
    int? internationalLicenseID,
    String? message,
    bool? canIssue,
  }) {
    return NewInternationalLicenseCubitLoaded(
      newInterLicePrevState:
          newInterLicePrevState ?? this.newInterLicePrevState,
      licenseId: licenseId ?? this.licenseId,
      internationalLicenseID:
          internationalLicenseID ?? this.internationalLicenseID,
      message: message ?? this.message,
      canIssue: canIssue ?? this.canIssue,
    );
  }

  @override
  List<Object?> get props => [
    newInterLicePrevState,
    licenseId,
    internationalLicenseID,
    message,
    canIssue,
  ];
}

final class NewInternationalLicenseCubitProcessing
    extends NewInternationalLicenseCubitState {}

final class NewInternationalLicenseCubitSuccess
    extends NewInternationalLicenseCubitState {
  final NewInternationalLicenseCubitLoaded? newInterLicePrevState;
  final IssueInternationalLicenseResult? issueILResult;

  const NewInternationalLicenseCubitSuccess({
    this.newInterLicePrevState,
    this.issueILResult,
  });

  @override
  List<Object?> get props => [newInterLicePrevState, issueILResult];
}

final class NewInternationalLicenseCubitFailure
    extends NewInternationalLicenseCubitState {
  final String message;

  const NewInternationalLicenseCubitFailure({required this.message});
}
