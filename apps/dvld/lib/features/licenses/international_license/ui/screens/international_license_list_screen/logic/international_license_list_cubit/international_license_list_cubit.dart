import 'dart:async';

import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_all_international_licenses_use_case.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/widgets/international_license_list_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'international_license_list_cubit_state.dart';

class InternationalLicenseListCubit
    extends Cubit<InternationalLicenseListCubitState> {
  InternationalLicenseListCubit(
    this._allInternationalLicenses,
    //  this._fetchDriverInfoByDriverIdUseCase,
    // this._getInfoPeopleByPersonIdUseCase,
  ) : super(InternationalLicenseListCubitInitial());

  final GetAllInternationalLicensesUseCase _allInternationalLicenses;

  // final FetchDriverInfoByDriverIdUseCase _fetchDriverInfoByDriverIdUseCase;

  // final GetInfoByIdUseCase _getInfoPeopleByPersonIdUseCase;

  Timer? _debounce;

  Future<void> getAllInternationalLicenses() async {
    emit(InternationalLicenseListCubitLoading());
    final result = await _allInternationalLicenses.call();
    result.fold(
      (failure) => emit(InternationalLicenseListCubitFailure(failure.message)),
      (internationalLicenses) => emit(
        InternationalLicenseListCubitLoaded(
          allEntries: internationalLicenses,
          filtered: internationalLicenses,
          filterColumn: InternationalLicenseListFilterColumn.none,
        ),
      ),
    );
  }

  void changeColumn(InternationalLicenseListFilterColumn column) {
    final state = this.state;

    if (state is! InternationalLicenseListCubitLoaded) return;

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

    if (state is! InternationalLicenseListCubitLoaded) return;

    final updated = state.copyWith(textValue: value);
    emit(updated);

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final currentState = this.state;
      if (currentState is InternationalLicenseListCubitLoaded) {
        _apply(currentState);
      }
    });
  }

  void changeBoolValue(bool? value) {
    final state = this.state;
    if (state is! InternationalLicenseListCubitLoaded) return;
    final updated = state.copyWith(boolValue: value);
    emit(updated);
    _apply(updated);
  }

  Future<void> refresh() => getAllInternationalLicenses();

  void _apply(InternationalLicenseListCubitLoaded state) {
    var result = state.allEntries;

    if (state.filterColumn.inputType == FilterInputType.booleanDropdown &&
        state.boolValue != null) {
      result = result.where((e) => e.isActive == state.boolValue).toList();
    } else if (state.filterColumn.inputType == FilterInputType.text &&
        state.textValue.trim().isNotEmpty) {
      final q = state.textValue.trim().toLowerCase();
      result = result
          .where(
            (e) => switch (state.filterColumn) {
              InternationalLicenseListFilterColumn.internationalId =>
                e.internationalLicenseId.toString().startsWith(q),
              InternationalLicenseListFilterColumn.applicationId =>
                e.applicationId.toString().startsWith(q),
              InternationalLicenseListFilterColumn.driverId =>
                e.driverId.toString().contains(q),
              InternationalLicenseListFilterColumn.licenseId =>
                e.issuedUsingLocalLicenseId.toString().contains(q),
              // InternationalLicenseListFilterColumn. =>
              //   e.driverId.toString().contains(q),
              // InternationalLicenseListFilterColumn.releaseAppId =>
              //   (e.releaseApplicationID?.toString() ?? '').startsWith(q),
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
