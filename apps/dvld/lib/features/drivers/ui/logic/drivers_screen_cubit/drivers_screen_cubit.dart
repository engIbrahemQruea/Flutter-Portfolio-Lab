import 'dart:async';

import 'package:dvld/features/drivers/domain/entities/read_entity/drivers_item_entity.dart';
import 'package:dvld/features/drivers/domain/use_cases/fetch_all_drivers_use_case.dart';
import 'package:dvld/features/drivers/ui/screen/widgets/drivers_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'drivers_screen_cubit_state.dart';

class DriversScreenCubit extends Cubit<DriversScreenCubitState> {
  DriversScreenCubit(this._fetchAllDriversUseCase)
    : super(DriversScreenCubitInitial());

  final FetchAllDriversUseCase _fetchAllDriversUseCase;

  Timer? _debounce;

  Future<void> fetchAllDrivers() async {
    emit(DriversScreenCubitLoading());
    final result = await _fetchAllDriversUseCase.call();
    result.fold(
      (l) => emit(DriversScreenCubitFailure(errorMessage: l.message)),
      (r) => emit(
        DriversScreenCubitLoaded(
          allDrivers: r,
          filtered: r,
          filterColumn: DriverFilterColumn.none,
          filterValue: '',
        ),
      ),
    );
  }

  void onFilterChanged({DriverFilterColumn? column, String? value}) {
    final state = this.state;
    if (state is! DriversScreenCubitLoaded) return;

    final newColumn = column ?? state.filterColumn;
    final newValue = value ?? state.filterValue;

    emit(state.copyWith(filterColumn: newColumn, filterValue: newValue));

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _applyFilter(newColumn, newValue);
    });
  }

  void _applyFilter(DriverFilterColumn column, String value) {
    final state = this.state;
    if (state is! DriversScreenCubitLoaded) return;

    if (value.trim().isEmpty || column.fieldName == null) {
      emit(state.copyWith(filtered: state.allDrivers));
      return;
    }

    final query = value.trim().toLowerCase();
    final filtered = state.allDrivers.where((d) {
      return switch (column) {
        DriverFilterColumn.driverId => d.driverID.toString().startsWith(query),
        DriverFilterColumn.personId => d.personID.toString().startsWith(query),
        DriverFilterColumn.nationalNo => d.nationalNo.toLowerCase().startsWith(
          query,
        ),
        DriverFilterColumn.fullName => d.fullName.toLowerCase().contains(query),
        DriverFilterColumn.none => true,
      };
    }).toList();

    emit(state.copyWith(filtered: filtered));
  }

  bool shouldAllowDigitsOnly(DriverFilterColumn column) => column.isNumeric;

  Future<void> refresh() => fetchAllDrivers();

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
