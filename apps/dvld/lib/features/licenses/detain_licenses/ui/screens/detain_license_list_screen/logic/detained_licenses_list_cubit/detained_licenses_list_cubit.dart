import 'dart:async';

import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_item_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/use_cases/get_all_detain_licenses_use_case.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_list_screen/widgets/detained_licenses_list_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detained_licenses_list_cubit_state.dart';

class DetainedLicensesListCubit extends Cubit<DetainedLicensesListCubitState> {
  DetainedLicensesListCubit(this._allDetainLicensesUseCase)
    : super(DetainedLicensesListCubitInitial());

  final GetAllDetainLicensesUseCase _allDetainLicensesUseCase;

  Timer? _debounce;

  Future<void> getAllDetainLicenses() async {
    emit(DetainedLicensesListCubitLoading());
    final result = await _allDetainLicensesUseCase.call();
    result.fold(
      (failure) =>
          emit(DetainedLicensesListCubitFailure(message: failure.message)),
      (detainLicenses) => emit(
        DetainedLicensesListCubitLoaded(
          allEntries: detainLicenses,
          filtered: detainLicenses,
          filterColumn: DetainedListFilterColumn.none,
        ),
      ),
    );
  }

  void changeColumn(DetainedListFilterColumn column) {
    final state = this.state;

    if (state is! DetainedLicensesListCubitLoaded) return;

    final updated = state.copyWith(
      filterColumn: column,
      textValue: '',
      boolValue: column.inputType == FilterInputType.booleanDropdown
          ? true
          : null,
      filtered: state.allEntries,
    );

    emit(updated);

    _apply(updated);
  }

  void changeTextValue(String value) {
    final state = this.state;

    if (state is! DetainedLicensesListCubitLoaded) return;

    final updated = state.copyWith(textValue: value);
    emit(updated);

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final currentState = this.state;
      if (currentState is DetainedLicensesListCubitLoaded) {
        _apply(currentState);
      }
    });
  }

  void changeBoolValue(bool? value) {
    final state = this.state;
    if (state is! DetainedLicensesListCubitLoaded) return;
    final updated = state.copyWith(boolValue: value);
    emit(updated);
    _apply(updated);
  }

  Future<void> refresh() => getAllDetainLicenses();

  void _apply(DetainedLicensesListCubitLoaded state) {
    var result = state.allEntries;

    if (state.filterColumn.inputType == FilterInputType.booleanDropdown &&
        state.boolValue != null) {
      result = result.where((e) => e.isReleased == state.boolValue).toList();
    } else if (state.filterColumn.inputType == FilterInputType.text &&
        state.textValue.trim().isNotEmpty) {
      final q = state.textValue.trim().toLowerCase();
      result = result
          .where(
            (e) => switch (state.filterColumn) {
              DetainedListFilterColumn.detainId =>
                e.detainID.toString().startsWith(q),
              DetainedListFilterColumn.nationalNo =>
                e.nationalNo.toLowerCase().startsWith(q),
              DetainedListFilterColumn.fullName =>
                e.fullName.toLowerCase().contains(q),
              DetainedListFilterColumn.releaseAppId =>
                (e.releaseApplicationID?.toString() ?? '').startsWith(q),
              _ => true,
            },
          )
          .toList();
    }

    emit(state.copyWith(filtered: result));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
