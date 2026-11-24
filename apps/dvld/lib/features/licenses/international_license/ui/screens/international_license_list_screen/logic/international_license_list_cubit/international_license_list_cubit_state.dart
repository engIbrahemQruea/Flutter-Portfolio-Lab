part of 'international_license_list_cubit.dart';

sealed class InternationalLicenseListCubitState extends Equatable {
  const InternationalLicenseListCubitState();

  @override
  List<Object> get props => [];
}

final class InternationalLicenseListCubitInitial
    extends InternationalLicenseListCubitState {}

final class InternationalLicenseListCubitLoading
    extends InternationalLicenseListCubitState {}

final class InternationalLicenseListCubitLoaded
    extends InternationalLicenseListCubitState {
  final List<InternationalLicenseEntity> allEntries;
  final List<InternationalLicenseEntity> filtered;
  final InternationalLicenseListFilterColumn filterColumn;
  final String textValue;
  final bool? boolValue;

  const InternationalLicenseListCubitLoaded({
    required this.allEntries,
    required this.filtered,
    required this.filterColumn,
    this.textValue = '',
    this.boolValue,
  });

  int get recordsCount => filtered.length;

  InternationalLicenseListCubitLoaded copyWith({
    List<InternationalLicenseEntity>? allEntries,
    List<InternationalLicenseEntity>? filtered,
    InternationalLicenseListFilterColumn? filterColumn,
    String? textValue,
    bool? boolValue,
  }) {
    return InternationalLicenseListCubitLoaded(
      allEntries: allEntries ?? this.allEntries,
      filtered: filtered ?? this.filtered,
      filterColumn: filterColumn ?? this.filterColumn,
      textValue: textValue ?? this.textValue,
      boolValue: boolValue ?? this.boolValue,
    );
  }

  @override
  List<Object> get props => [
    allEntries,
    filtered,
    filterColumn,
    textValue,
    boolValue ?? false,
  ];
}

final class InternationalLicenseListCubitFailure
    extends InternationalLicenseListCubitState {
  final String message;
  const InternationalLicenseListCubitFailure(this.message);
}
