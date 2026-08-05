import 'package:dvld/core/helpers/forms/enums.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_user_id_use_case.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/usecases/get_country_name_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_id_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_information_card_cubit_state.dart';

class UserInformationCardCubit extends Cubit<UserInformationCardCubitState> {
  UserInformationCardCubit(
    this._getUserInfoByUserIdUseCase,
    this._getPersonInfoByIdUseCase,
    this._getCountryNameByIdUseCase,
  ) : super(UserInformationCardCubitState());

  final GetUserInfoByUserIdUseCase _getUserInfoByUserIdUseCase;
  final GetInfoByIdUseCase _getPersonInfoByIdUseCase;
  final GetCountryNameByIdUseCase _getCountryNameByIdUseCase;

  Future<void> getUserDetails({required int? userId}) async {
    if (userId == 0 || userId == null) {
      emit(
        state.copyWith(
          showDetailsUserScreenStatus: () => RequestStatus.failure,
          errorMessage: () => 'Invalid user ID',
        ),
      );
      return;
    }

    emit(
      state.copyWith(showDetailsUserScreenStatus: () => RequestStatus.loading),
    );

    final userResult = await _getUserInfoByUserIdUseCase.call(userId);
    userResult.fold(
      (failure) => emit(
        state.copyWith(
          showDetailsUserScreenStatus: () => RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (user) async {
        if (user == null) {
          emit(
            state.copyWith(
              showDetailsUserScreenStatus: () => RequestStatus.failure,
              errorMessage: () => 'User not found',
            ),
          );
          return;
        }

        final peopleResult = await _getPersonInfoByIdUseCase.call(
          user.personID,
        );
        peopleResult.fold(
          (failure) => emit(
            state.copyWith(
              showDetailsUserScreenStatus: () => RequestStatus.failure,
              errorMessage: () => failure.message,
            ),
          ),
          (people) async {
            if (people == null) {
              emit(
                state.copyWith(
                  showDetailsUserScreenStatus: () => RequestStatus.failure,
                  errorMessage: () => 'Person not found',
                ),
              );
              return;
            }

            final countryResult = await _getCountryNameByIdUseCase.call(
              people.nationalityCountryId,
            );
            countryResult.fold(
              (failure) => emit(
                state.copyWith(
                  showDetailsUserScreenStatus: () => RequestStatus.failure,
                  errorMessage: () => failure.message,
                ),
              ),
              (countryName) {
                emit(
                  state.copyWith(
                    showDetailsUserScreenStatus: () => RequestStatus.success,
                    userEntity: () => user,
                    peopleEntity: () => people,
                    countryName: () => countryName,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> refreshPersonInfo({required int personID}) async {
    // emit(
    //   state.copyWith(showDetailsUserScreenStatus: () => RequestStatus.loading),
    // );

    final result = await _getPersonInfoByIdUseCase.call(personID);
    result.fold(
      (failure) => emit(
        state.copyWith(
          showDetailsUserScreenStatus: () => RequestStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (people) async {
        if (people == null) {
          state.copyWith(
            showDetailsUserScreenStatus: () => RequestStatus.failure,
            errorMessage: () => 'Person not found',
          );
          return;
        }

        final countryResult = await _getCountryNameByIdUseCase.call(
          people.nationalityCountryId,
        );
        countryResult.fold(
          (failure) => emit(
            state.copyWith(
              showDetailsUserScreenStatus: () => RequestStatus.failure,
              errorMessage: () => failure.message,
            ),
          ),
          (countryName) {
            emit(
              state.copyWith(
                showDetailsUserScreenStatus: () => RequestStatus.success,
                peopleEntity: () => people,
                countryName: () => countryName,
              ),
            );
          },
        );
      },
    );
  }
}
