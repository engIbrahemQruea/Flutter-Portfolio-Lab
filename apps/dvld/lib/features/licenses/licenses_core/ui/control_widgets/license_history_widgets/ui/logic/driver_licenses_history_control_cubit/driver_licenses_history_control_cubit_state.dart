part of 'driver_licenses_history_control_cubit.dart';

sealed class DriverLicensesHistoryControlCubitState extends Equatable {
  const DriverLicensesHistoryControlCubitState();

  @override
  List<Object> get props => [];
}

final class DriverLicensesHistoryControlCubitInitial
    extends DriverLicensesHistoryControlCubitState {}

final class DriverLicensesHistoryControlCubitLoading
    extends DriverLicensesHistoryControlCubitState {}

final class DriverLicensesHistoryControlCubitEmpty
    extends DriverLicensesHistoryControlCubitState {
      final String message;

      const DriverLicensesHistoryControlCubitEmpty({
        required this.message,
      });
    }

final class DriverLicensesHistoryControlCubitLoaded
    extends DriverLicensesHistoryControlCubitState {
  final List<LocalLicenseHistoryEntity> localLicenses;
  final List<InternationalLicenseEntity> internationalLicenses;

  const DriverLicensesHistoryControlCubitLoaded({
    required this.localLicenses,
    required this.internationalLicenses,
  });

  int get localLicenseCount => localLicenses.length;
  int get internationalLicenseCount => internationalLicenses.length;

  DriverLicensesHistoryControlCubitLoaded copyWith({
    List<LocalLicenseHistoryEntity>? localLicenses,
    List<InternationalLicenseEntity>? internationalLicenses,
  }) {
    return DriverLicensesHistoryControlCubitLoaded(
      localLicenses: localLicenses ?? this.localLicenses,
      internationalLicenses: internationalLicenses ?? this.internationalLicenses,
    );
  }

  @override
  List<Object> get props => [localLicenses, internationalLicenses];
}

final class DriverLicensesHistoryControlCubitFailure
    extends DriverLicensesHistoryControlCubitState {
  final String failureMessage;

  const DriverLicensesHistoryControlCubitFailure({
    required this.failureMessage,
  });
}
