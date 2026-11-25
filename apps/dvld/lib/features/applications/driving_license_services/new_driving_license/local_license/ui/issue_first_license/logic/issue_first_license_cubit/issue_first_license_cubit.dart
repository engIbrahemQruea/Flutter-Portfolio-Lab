import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/issue_first_license_use_case.dart';
import 'package:dvld/features/login/domain/login_use_cases/get_data_shared_pref_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issue_first_license_cubit_state.dart';

class IssueFirstLicenseCubit extends Cubit<IssueFirstLicenseCubitState> {
  IssueFirstLicenseCubit(
    this._issueFirstLicenseUseCase,
    this._getDataSharedPrefUseCase,
  ) : super(const IssueFirstLicenseCubitInitial());

  final IssueFirstLicenseUseCase _issueFirstLicenseUseCase;

  final GetDataSharedPrefUseCase _getDataSharedPrefUseCase;

  void setLocalDLAppId({required int localDLApplicationId}) {
    if (state is IssueFirstLicenseCubitInitial) {
      emit(
        (state as IssueFirstLicenseCubitInitial).copyWith(
          localDLAppId: localDLApplicationId,
        ),
      );
    }
  }

  void changeNote(String note) {
    if (state is IssueFirstLicenseCubitInitial) {
      emit((state as IssueFirstLicenseCubitInitial).copyWith(note: note));
    }
  }

  Future<void> submitIssueFirstLicense() async {
    final currentAppId = state.localDLAppId;
    final currentNote = state.note;

    if (currentAppId == null) {
      emit(
        IssueFirstLicenseCubitFailure(
          errorMessage: 'Local Driving License Application ID is missing',
          localDLAppId: currentAppId,
          note: currentNote,
        ),
      );
      return;
    }

    final currentUser = await _getDataSharedPrefUseCase.call(
      stringKey: sharedPrefKeyCurrentUser,
    );

    final userId = currentUser?.userId;
    if (userId == null) {
      emit(
        IssueFirstLicenseCubitFailure(
          errorMessage: 'User ID is null or user is not logged in',
          localDLAppId: currentAppId,
          note: currentNote,
        ),
      );
      return;
    }

    emit(
      IssueFirstLicenseCubitLoading(
        localDLAppId: currentAppId,
        note: currentNote,
      ),
    );

    final IssueFirstLicenseParam params = (
      localDLApplicationId: currentAppId,
      notes: currentNote,
      createdByUserId: userId,
    );

    final result = await _issueFirstLicenseUseCase(params);

    result.fold(
      (failure) => emit(
        IssueFirstLicenseCubitFailure(
          errorMessage: failure.message,
          localDLAppId: currentAppId,
          note: currentNote,
        ),
      ),
      (licenseId) => emit(
        IssueFirstLicenseCubitSuccess(
          licenseId: licenseId,
          localDLAppId: currentAppId,
          note: currentNote,
        ),
      ),
    );
  }
}
