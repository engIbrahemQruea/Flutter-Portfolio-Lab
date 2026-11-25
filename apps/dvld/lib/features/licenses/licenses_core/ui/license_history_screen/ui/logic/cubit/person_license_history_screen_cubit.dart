import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'person_license_history_screen_cubit_state.dart';

class PersonLicenseHistoryScreenCubit
    extends Cubit<PersonLicenseHistoryScreenCubitState> {
  PersonLicenseHistoryScreenCubit()
    : super(PersonLicenseHistoryScreenCubitInitial());

  void onPersonSelected(int personId) {
    if (personId <= 0 || personId == null) {
      emit(PersonNoSelectedLicenseHistoryScreenCubit());
      return;
    }
    emit(PersonSelectedLicenseHistoryScreenCubit(personId: personId));
  }
}
