part of 'release_detained_license_cubit.dart';

sealed class ReleaseDetainedLicenseCubitState extends Equatable {
  const ReleaseDetainedLicenseCubitState();

  @override
  List<Object?> get props => [];
}

final class ReleaseDetainedLicenseCubitInitial
    extends ReleaseDetainedLicenseCubitState {}

final class ReleaseDetainedLicenseCubitLoading
    extends ReleaseDetainedLicenseCubitState {}

final class ReleaseDetainedLicenseCubitLoaded
    extends ReleaseDetainedLicenseCubitState {
  final ReleaseDetainedLicenseReadEntity? releaseDetLiReadEntity;
  final String? errorMessage;
  final bool canRelease;

  const ReleaseDetainedLicenseCubitLoaded({
     this.releaseDetLiReadEntity,
    this.errorMessage,
    this.canRelease = false,
  });

  @override
  List<Object?> get props => [releaseDetLiReadEntity, errorMessage, canRelease];
}

final class ReleaseDetainedLicenseCubitProcessing
    extends ReleaseDetainedLicenseCubitState {
  final ReleaseDetainedLicenseCubitLoaded releaseDetLiPrevState;

  const ReleaseDetainedLicenseCubitProcessing({
    required this.releaseDetLiPrevState,
  });
}

final class ReleaseDetainedLicenseCubitSuccess
    extends ReleaseDetainedLicenseCubitState {
  final ReleaseDetainedLicenseCubitLoaded releaseDetLiPrevState;
  final int applicationID;

  const ReleaseDetainedLicenseCubitSuccess({
    required this.releaseDetLiPrevState,
    required this.applicationID,
  });

  @override
  List<Object?> get props => [releaseDetLiPrevState, applicationID];
}

final class ReleaseDetainedLicenseCubitFailure
    extends ReleaseDetainedLicenseCubitState {
  final String message;

  const ReleaseDetainedLicenseCubitFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
