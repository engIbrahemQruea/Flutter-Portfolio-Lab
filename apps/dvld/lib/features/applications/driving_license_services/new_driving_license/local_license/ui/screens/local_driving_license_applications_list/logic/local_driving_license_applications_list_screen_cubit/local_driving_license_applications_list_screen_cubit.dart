import 'dart:async';

import 'package:dvld/core/helpers/forms/forms.dart';
import 'package:dvld/features/applications/applications_core/domain/use_cases/index_app_core_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_item_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/read_entity/local_application_menu_permissions_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/index_local_license_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/helper_list_local_dr_li_app/local_application_filter_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'local_driving_license_applications_list_screen_cubit_state.dart';

class LocalDrivingLicenseApplicationsListScreenCubit
    extends Cubit<LocalDrivingLicenseApplicationsListScreenCubitState> {
  LocalDrivingLicenseApplicationsListScreenCubit(
    this._getAllLocalDrivingLicenseApplicationUseCase,
    this._getLocalApplicationMenuPermissionsUseCase,
    this._deleteLocalDrLiAppAndAppAndApplicationUseCase,
    this._cancelApplicationUseCase,
    this._getLocalDrivingLicenseApplicationInfoByIdUseCase,
  ) : super(LocalDrivingLicenseApplicationsListScreenCubitState());

  final GetAllLocalDrivingLicenseApplicationUseCase
  _getAllLocalDrivingLicenseApplicationUseCase;
  final GetLocalApplicationMenuPermissionsUseCase
  _getLocalApplicationMenuPermissionsUseCase;
  final DeleteLocalDrLiAppAndApplicationUseCase
  _deleteLocalDrLiAppAndAppAndApplicationUseCase;
  final CancelApplicationUseCase _cancelApplicationUseCase;
  final GetLocalDrivingLicenseApplicationInfoByIdUseCase
  _getLocalDrivingLicenseApplicationInfoByIdUseCase;

  Timer? _debounceTimer;

  void onFilterTypeSelected(LocalApplicationFilterType filterType) => emit(
    state.copyWith(localAppFilterType: filterType, filterValue: () => ''),
  );

  void onFilterValueChanged(String value) {
    emit(state.copyWith(filterValue: () => value));
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _applyFilter(value.trim());
    });
  }

  void _applyFilter(String query) {
    if (query.isEmpty ||
        state.localAppFilterType == LocalApplicationFilterType.none) {
      emit(
        state.copyWith(
          filteredApplicationsList: state.applicationsList,
          loadLocalAppStatus: RequestStatus.success,
        ),
      );
      return;
    }
    final List<LocalDrivingLicenseApplicationListItemEntity> filteredAppList =
        switch (state.localAppFilterType) {
          LocalApplicationFilterType.lDLAppID =>
            state.applicationsList
                .where(
                  (app) => app.localDrLiAppViewId.toString().contains(query),
                )
                .toList(),
          LocalApplicationFilterType.nationalNo =>
            state.applicationsList
                .where((app) => app.nationalNo.toString().contains(query))
                .toList(),
          LocalApplicationFilterType.fullName =>
            state.applicationsList
                .where((app) => app.fullName.toString().contains(query))
                .toList(),
          LocalApplicationFilterType.status =>
            state.applicationsList
                .where((app) => app.status.toString().contains(query))
                .toList(),
          _ => [],
        };

    emit(
      state.copyWith(
        filteredApplicationsList: filteredAppList,
        loadLocalAppStatus: RequestStatus.success,
      ),
    );
  }

  Future<void> getAllLocalDrivingLicenseApplications() async {
    emit(state.copyWith(loadLocalAppStatus: RequestStatus.loading));

    final result = await _getAllLocalDrivingLicenseApplicationUseCase.call();

    result.fold(
      (failure) => emit(
        state.copyWith(
          loadLocalAppStatus: RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),

      (applications) => emit(
        state.copyWith(
          loadLocalAppStatus: RequestStatus.success,
          applicationsList: applications,
          filteredApplicationsList: applications,
        ),
      ),
    );
  }

  Future<void> getLocalApplicationMenuPermissions({
    required LocalDrivingLicenseApplicationListItemEntity localDLAppItemEntity,
  }) async {
    final permissions = await _getLocalApplicationMenuPermissionsUseCase.call(
      localDLAppItemEntity: localDLAppItemEntity,
    );
    emit(state.copyWith(permissionsMenu: permissions));
  }

  Future<void> deleteLocalDrivingLicenseApplication({
    required int localDriLiceApplicationId,
  }) async {
    emit(state.copyWith(loadLocalAppStatus: RequestStatus.loading));

    final deleteResult = await _deleteLocalDrLiAppAndAppAndApplicationUseCase
        .call(localDriLiceApplicationId: localDriLiceApplicationId);

    deleteResult.fold(
      (failure) => emit(
        state.copyWith(
          loadLocalAppStatus: RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (deleted) =>
          emit(state.copyWith(loadLocalAppStatus: RequestStatus.success)),
    );
  }

  Future<void> cancelApplication({
    required int localDriLiceApplicationId,
  }) async {
    emit(state.copyWith(loadLocalAppStatus: RequestStatus.loading));

    final resultLocalAppInfo =
        await _getLocalDrivingLicenseApplicationInfoByIdUseCase.call(
          localDriLiceApplicationId,
        );

    resultLocalAppInfo.fold(
      (failure) => emit(
        state.copyWith(
          loadLocalAppStatus: RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (localAppInfo) async {
        final result = await _cancelApplicationUseCase.call(
          localAppInfo.applicationId,
        );

        result.fold(
          (failure) => emit(
            state.copyWith(
              loadLocalAppStatus: RequestStatus.failure,
              errorMessage: () => failure.message,
            ),
          ),
          (isDeleted) =>
              emit(state.copyWith(loadLocalAppStatus: RequestStatus.success)),
        );
      },
    );
  }
}
