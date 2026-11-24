part of 'detained_licenses_list_cubit.dart';

sealed class DetainedLicensesListCubitState extends Equatable {
  const DetainedLicensesListCubitState();

  @override
  List<Object?> get props => [];
}

final class DetainedLicensesListCubitInitial
    extends DetainedLicensesListCubitState {}

final class DetainedLicensesListCubitLoading
    extends DetainedLicensesListCubitState {}

final class DetainedLicensesListCubitLoaded
    extends DetainedLicensesListCubitState {
  final List<DetainLicenseItemEntity> allEntries;
  final List<DetainLicenseItemEntity> filtered;
  final DetainedListFilterColumn filterColumn;
  final String textValue;
  final bool? boolValue;

  const DetainedLicensesListCubitLoaded({
    required this.allEntries,
    required this.filtered,
    required this.filterColumn,
    this.textValue = '',
    this.boolValue,
  });

  int get recordsCount => filtered.length;

  DetainedLicensesListCubitLoaded copyWith({
    List<DetainLicenseItemEntity>? allEntries,
    List<DetainLicenseItemEntity>? filtered,
    DetainedListFilterColumn? filterColumn,
    String? textValue,
    bool? boolValue,
  }) {
    return DetainedLicensesListCubitLoaded(
      allEntries: allEntries ?? this.allEntries,
      filtered: filtered ?? this.filtered,
      filterColumn: filterColumn ?? this.filterColumn,
      textValue: textValue ?? this.textValue,
      boolValue: boolValue ?? this.boolValue,
    );
  }

  @override
  List<Object?> get props => [
    allEntries,
    filtered,
    filterColumn,
    textValue,
    boolValue,
  ];
}

final class DetainedLicensesListCubitFailure
    extends DetainedLicensesListCubitState {
  final String message;

  const DetainedLicensesListCubitFailure({required this.message});
}
