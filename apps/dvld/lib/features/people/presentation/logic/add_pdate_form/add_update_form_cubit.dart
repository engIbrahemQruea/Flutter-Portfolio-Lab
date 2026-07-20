import 'dart:async';
import 'dart:io';

import 'package:dvld/core/helpers/app_regex.dart';
import 'package:dvld/core/helpers/cls_utility.dart';
import 'package:dvld/features/people/data/repos_imp/people_repos_imp.dart';
import 'package:dvld/features/people/domain/entities/county_entity.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/usecases/add_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/is_national_no_exists_use_case.dart';
import 'package:dvld/features/people/domain/usecases/update_people_use_case.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_update_form_state.dart';

class AddUpdateFormCubit extends Cubit<AddUpdateFormState> {
  AddUpdateFormCubit(
    this._isNationalNoExistsUseCase,
    this._addPeopleUseCase,
    this._updatePeopleUseCase,
    this._peopleReposImp,
    this._getInfoByIdUseCase,
  ) : super(AddUpdateFormState.initial());

  final IsNationalNoExistsUseCase _isNationalNoExistsUseCase;
  final AddPeopleUseCase _addPeopleUseCase;
  final UpdatePeopleUseCase _updatePeopleUseCase;
  final GetInfoByIdUseCase _getInfoByIdUseCase;
  final PeopleReposImp _peopleReposImp;

  Timer? _nationalNoDebounce;

  void initializeWithDataModeUpdate({
    required int personId,
    required AddUpdatePeopleFormControllers controllers,
  }) async {
    emit(state.copyWith(loadPersonStatus: RequestStatus.loading));

    final peopleEntity = await _getInfoByIdUseCase.call(personId);

    peopleEntity.fold(
      (failure) => emit(
        state.copyWith(
          loadPersonStatus: RequestStatus.failure,
          saveButtonStatus: state.saveButtonStatus.copyWith(
            saveStatus: RequestStatus.failure,
            errorMessage: () => failure.message,
          ),
        ),
      ),
      (people) async {
        if (people != null) {
          await getInfoCountryByID(countryID: people.nationalityCountryId);
          controllers.updateControllersFromModel(
            people: people,
            countryName: state.countryStatus.selectedCountryName!,
          );
          emit(
            state.copyWith(
              screenStatusMode: ScreenStatus.update,
              loadPersonStatus: RequestStatus.success,
              firstName: state.firstName.copyWith(
                value: people.firstName,
                isValid: true,
              ),
              secondName: state.secondName.copyWith(
                value: people.secondName,
                isValid: true,
              ),
              thirdName: state.thirdName.copyWith(
                value: people.thirdName ?? '',
                isValid: people.thirdName != null ? true : false,
              ),
              lastName: state.lastName.copyWith(
                value: people.lastName,
                isValid: true,
              ),
              notionalNo: state.nationalNo.copyWith(
                value: people.nationalNo,
                isValid: true,
              ),
              dateOfBirth: state.dateOfBirth.copyWith(
                value: people.dateOfBirth,
                isValid: true,
              ),
              phoneNumber: state.phoneNumber.copyWith(
                value: people.phone,
                isValid: true,
              ),
              email: state.email.copyWith(
                value: people.email,
                isValid: people.email != null ? true : false,
              ),
              address: state.address.copyWith(
                value: people.address,
                isValid: true,
              ),
              imagePickerState: state.imagePickerState.copyWith(
                imagePath: people.imagePath,
              ),
            ),
          );
        }
      },
    );
  }

  void _updateTextField({
    required FormFieldState<String> field,
    required String value,
    required String errorMessage,
    required AddUpdateFormState Function(FormFieldState<String> updatedField)
    onEmit,
  }) {
    if (value.isEmpty) {
      emit(
        onEmit(
          field.copyWith(
            value: value,
            isValid: false,
            error: () => errorMessage,
          ),
        ),
      );
    } else {
      emit(
        onEmit(field.copyWith(value: value, isValid: true, error: () => null)),
      );
    }
  }

  void onChangeFirstName(String value) {
    _updateTextField(
      field: state.firstName,
      value: value,
      errorMessage: 'First Name is required',
      onEmit: (updated) => state.copyWith(firstName: updated),
    );
  }

  void onChangeSecondName(String value) {
    _updateTextField(
      field: state.secondName,
      value: value,
      errorMessage: 'Second Name is required',
      onEmit: (updated) => state.copyWith(secondName: updated),
    );
  }

  void onChangeThirdName(String value) {
    emit(
      state.copyWith(
        thirdName: state.thirdName.copyWith(
          value: value,
          isValid: value.isNotEmpty,
          error: () => null,
        ),
      ),
    );
  }

  void onChangeLastName(String value) {
    _updateTextField(
      field: state.lastName,
      value: value,
      errorMessage: 'Last Name is required',
      onEmit: (updated) => state.copyWith(lastName: updated),
    );
  }

  void onChangeNationalNo(String value) {
    _nationalNoDebounce?.cancel();

    if (value.isEmpty) {
      emit(
        state.copyWith(
          notionalNo: state.nationalNo.copyWith(
            value: value,
            isValid: false,
            isChecking: false,
            error: () => 'National No is required',
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        notionalNo: state.nationalNo.copyWith(value: value, isChecking: true),
      ),
    );

    _nationalNoDebounce = Timer(const Duration(milliseconds: 600), () async {
      final exists = await _isNationalNoExistsUseCase.call(value);
      exists.fold(
        (failure) {
          emit(
            state.copyWith(
              notionalNo: state.nationalNo.copyWith(
                value: value,
                isValid: false,
                isChecking: false,
                error: () => failure.message,
              ),
            ),
          );
        },
        (isExists) {
          if (isExists) {
            emit(
              state.copyWith(
                notionalNo: state.nationalNo.copyWith(
                  value: value,
                  isValid: false,
                  isChecking: false,
                  error: () => 'NationalNo already exists',
                ),
              ),
            );
          } else {
            emit(
              state.copyWith(
                notionalNo: state.nationalNo.copyWith(
                  value: value,
                  isValid: true,
                  isChecking: false,
                  error: () => null,
                ),
              ),
            );
          }
        },
      );
    });
  }

  void onChangeDateOfBirth(String value) {
    _updateTextField(
      field: state.dateOfBirth,
      value: value,
      errorMessage: 'Date of Birth is required',
      onEmit: (updated) => state.copyWith(dateOfBirth: updated),
    );
  }

  void onChangePhoneNumber(String value) {
    _updateTextField(
      field: state.phoneNumber,
      value: value,
      errorMessage: 'Phone Number is required',
      onEmit: (updated) => state.copyWith(phoneNumber: updated),
    );
  }

  void onChangeEmail(String value) {
    if (AppRegex.isEmailValid(value)) {
      emit(
        state.copyWith(
          email: state.email.copyWith(
            value: value,
            isValid: true,
            error: () => null,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          email: state.email.copyWith(
            value: value,
            isValid: false,
            error: () => 'Invalid format ex: 2rMg5@amp.co',
          ),
        ),
      );
    }
  }

  void onChangeAddress(String value) {
    _updateTextField(
      field: state.address,
      value: value,
      errorMessage: 'Address is required',
      onEmit: (updated) => state.copyWith(address: updated),
    );
  }

  void onChangeImagePicker({required String imagePath}) {
    emit(
      state.copyWith(
        imagePickerState: state.imagePickerState.copyWith(imagePath: imagePath),
      ),
    );
  }

  String? handlePersonImage(String oldImagePath) {
    final String? currentImagePath = state.imagePickerState.imagePath;
    if (currentImagePath != oldImagePath) {
      if (oldImagePath.isNotEmpty) {
        final oldFile = File(oldImagePath);
        if (oldFile.existsSync()) {
          try {
            oldFile.deleteSync();
          } catch (e) {
            print("Failed to delete old image: $e");
          }
        }
      }
      if (currentImagePath != null && currentImagePath.isNotEmpty) {
        final newPath = ClsUtility.copyImageToProjectImagesFolder(
          sourceFile: currentImagePath,
        );
        return newPath;
      }
    }
    return currentImagePath;
  }

  Future<void> emitSaveAddPerson({required PeopleEntity personEntity}) async {
    emit(
      state.copyWith(
        saveButtonStatus: state.saveButtonStatus.copyWith(
          saveStatus: RequestStatus.loading,
        ),
      ),
    );

    final result = await _addPeopleUseCase.call(personEntity);

    result.fold(
      (failure) => emit(
        state.copyWith(
          saveButtonStatus: state.saveButtonStatus.copyWith(
            saveStatus: RequestStatus.failure,
            errorMessage: () => failure.message,
          ),
        ),
      ),

      (success) => emit(
        state.copyWith(
          saveButtonStatus: state.saveButtonStatus.copyWith(
            saveStatus: RequestStatus.success,
          ),
        ),
      ),
    );
  }

  Future<void> emitSaveUpdatePerson({
    required PeopleEntity personEntity,
  }) async {
    emit(
      state.copyWith(
        saveButtonStatus: state.saveButtonStatus.copyWith(
          saveStatus: RequestStatus.loading,
        ),
      ),
    );

    final result = await _updatePeopleUseCase.call(personEntity);

    result.fold(
      (failure) => emit(
        state.copyWith(
          saveButtonStatus: state.saveButtonStatus.copyWith(
            saveStatus: RequestStatus.failure,
            errorMessage: () => failure.message,
          ),
        ),
      ),
      (success) => emit(
        state.copyWith(
          saveButtonStatus: state.saveButtonStatus.copyWith(
            saveStatus: RequestStatus.success,
          ),
        ),
      ),
    );
  }

  /// Country Management

  Future<void> getAllCountries() async {
    emit(
      state.copyWith(
        countryStatus: state.countryStatus.copyWith(
          loadCountryStatus: RequestStatus.loading,
        ),
      ),
    );

    final result = await _peopleReposImp.getAllCountries();

    result.fold(
      (failure) => emit(
        state.copyWith(
          countryStatus: state.countryStatus.copyWith(
            loadCountryStatus: RequestStatus.failure,
            errorMessage: () => failure.message,
          ),
        ),
      ),

      (countries) => emit(
        state.copyWith(
          countryStatus: state.countryStatus.copyWith(
            loadCountryStatus: RequestStatus.success,
            countries: countries,
          ),
        ),
      ),
    );
  }

  Future<void> getInfoCountryByName({required String countryName}) async {
    emit(
      state.copyWith(
        countryStatus: state.countryStatus.copyWith(
          loadCountryStatus: RequestStatus.loading,
        ),
      ),
    );

    final result = await _peopleReposImp.getCountryIdByName(
      countryName: countryName,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          countryStatus: state.countryStatus.copyWith(
            loadCountryStatus: RequestStatus.failure,
            errorMessage: () => failure.message,
          ),
        ),
      ),

      (country) => emit(
        state.copyWith(
          countryStatus: state.countryStatus.copyWith(
            loadCountryStatus: RequestStatus.success,
            selectedCountryID: country,
          ),
        ),
      ),
    );
  }

  Future<void> getInfoCountryByID({required int countryID}) async {
    emit(
      state.copyWith(
        countryStatus: state.countryStatus.copyWith(
          loadCountryStatus: RequestStatus.loading,
        ),
      ),
    );

    final result = await _peopleReposImp.getCountryNameById(
      countryId: countryID,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          countryStatus: state.countryStatus.copyWith(
            loadCountryStatus: RequestStatus.failure,
            errorMessage: () => failure.message,
          ),
        ),
      ),

      (countryName) => emit(
        state.copyWith(
          countryStatus: state.countryStatus.copyWith(
            loadCountryStatus: RequestStatus.success,
            selectedCountryName: countryName,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _nationalNoDebounce?.cancel();
    return super.close();
  }
}
