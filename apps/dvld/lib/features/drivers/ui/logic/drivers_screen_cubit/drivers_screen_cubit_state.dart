part of 'drivers_screen_cubit.dart';

sealed class DriversScreenCubitState extends Equatable {
  const DriversScreenCubitState();

  @override
  List<Object> get props => [];
}

final class DriversScreenCubitInitial extends DriversScreenCubitState {}

final class DriversScreenCubitLoading extends DriversScreenCubitState {}

final class DriversScreenCubitLoaded extends DriversScreenCubitState {
  final List<DriversItemEntity> allDrivers;
  final List<DriversItemEntity> filtered;
  final DriverFilterColumn filterColumn;
  final String filterValue;

  const DriversScreenCubitLoaded({
    required this.allDrivers,
    required this.filtered,
    required this.filterColumn,
    required this.filterValue,
  });

  int get recordsCount => filtered.length;
  bool get hasActiveFilter =>
      filterValue.isNotEmpty && filterColumn.fieldName != null;

  DriversScreenCubitLoaded copyWith({
    List<DriversItemEntity>? filtered,
    DriverFilterColumn? filterColumn,
    String? filterValue,
  }) => DriversScreenCubitLoaded(
    allDrivers: allDrivers,
    filtered: filtered ?? this.filtered,
    filterColumn: filterColumn ?? this.filterColumn,
    filterValue: filterValue ?? this.filterValue,
  );

  @override
  List<Object> get props => [allDrivers, filtered, filterColumn, filterValue];
}

final class DriversScreenCubitFailure extends DriversScreenCubitState {
  final String errorMessage;
  const DriversScreenCubitFailure({required this.errorMessage});
}
