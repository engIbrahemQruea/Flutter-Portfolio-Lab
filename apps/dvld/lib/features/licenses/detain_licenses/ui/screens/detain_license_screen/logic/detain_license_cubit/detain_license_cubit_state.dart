part of 'detain_license_cubit.dart';

sealed class DetainLicenseCubitState extends Equatable {
  const DetainLicenseCubitState();

  @override
  List<Object> get props => [];
}

final class DetainLicenseCubitInitial extends DetainLicenseCubitState {}

final class DetainLicenseCubitLoading extends DetainLicenseCubitState {}

final class DetainNoLicenseCubit extends DetainLicenseCubitState {
  final DateTime? detainDate;
  final LoginEntity loginEntity;
  DetainNoLicenseCubit(this.loginEntity) : detainDate = DateTime.now();

  @override
  List<Object> get props => [loginEntity, detainDate!];
}

final class DetainLicenseCubitLoaded extends DetainLicenseCubitState {
  final DetainNoLicenseCubit detainNoLicenseCubit;
  final int? licenseID;
  final String? errorMessage;
  final bool canDetain;

  const DetainLicenseCubitLoaded({
    required this.detainNoLicenseCubit,
    this.licenseID,
    this.errorMessage,
    this.canDetain = false,
  });

  @override
  List<Object> get props => [detainNoLicenseCubit, licenseID!, canDetain];
}

final class DetainLicenseCubitSuccess extends DetainLicenseCubitState {
  final DetainLicenseCubitLoaded detainLicensePrevious;
  final int newDetainLicenseID;
  const DetainLicenseCubitSuccess(
    this.detainLicensePrevious,
    this.newDetainLicenseID,
  );
}

final class DetainLicenseCubitProcessing extends DetainLicenseCubitState {
  final DetainLicenseCubitLoaded detainLicensePrevious;
  const DetainLicenseCubitProcessing(
    this.detainLicensePrevious,
  );
}

final class DetainLicenseCubitFailure extends DetainLicenseCubitState {
  final String errorMessage;
  const DetainLicenseCubitFailure(this.errorMessage);
}
