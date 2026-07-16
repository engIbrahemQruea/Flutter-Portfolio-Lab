// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_update_form_cubit.dart';

enum ScreenStatus { add, update }

enum RequestStatus { initial, loading, success, failure }

enum NationalNoStatus { initial, checking, valid, exists, failure }

enum ImagePickerStatus { initial, picking, selected, cancelled, failure }

class FormFieldState<T> extends Equatable {
  final T value;
  final String? error;
  final bool isValid;
  final bool isChecking;

  const FormFieldState({
    required this.value,
    this.error,
    this.isValid = false,
    this.isChecking = false,
  });

  FormFieldState<T> copyWith({
    T? value,
    String? Function()? error,
    bool? isValid,
    bool? isChecking,
  }) {
    return FormFieldState<T>(
      value: value ?? this.value,
      error: error != null ? error() : this.error,
      isValid: isValid ?? this.isValid,
      isChecking: isChecking ?? this.isChecking,
    );
  }

  @override
  List<Object?> get props => [value, error, isValid, isChecking];
}

class SaveButtonState extends Equatable {
  final RequestStatus saveStatus;
  final String? errorMessage;

  const SaveButtonState({required this.saveStatus, this.errorMessage});

  SaveButtonState copyWith({
    RequestStatus? saveStatus,
    String? Function()? errorMessage,
  }) {
    return SaveButtonState(
      saveStatus: saveStatus ?? this.saveStatus,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [saveStatus, errorMessage];
}

class CountryState extends Equatable {
  final RequestStatus loadCountryStatus;

  final List<CountyEntity>? countries;
  final String? errorMessage;
  final int? selectedCountryID;
  final String? selectedCountryName;

  const CountryState({
    required this.loadCountryStatus,
    this.countries,
    this.errorMessage,
    this.selectedCountryID,
    this.selectedCountryName,
  });

  CountryState copyWith({
    RequestStatus? loadCountryStatus,
    List<CountyEntity>? countries,
    int? selectedCountryID,
    String? selectedCountryName,
    String? Function()? errorMessage,
  }) {
    return CountryState(
      loadCountryStatus: loadCountryStatus ?? this.loadCountryStatus,
      countries: countries ?? this.countries,
      selectedCountryID: selectedCountryID ?? this.selectedCountryID,
      selectedCountryName: selectedCountryName ?? this.selectedCountryName,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loadCountryStatus,
    countries,
    selectedCountryID,
    selectedCountryName,
    errorMessage,
  ];
}

class AddUpdateFormState extends Equatable {
  final PeopleEntity? personEntity;

  final FormFieldState<String> firstName;
  final FormFieldState<String> secondName;
  final FormFieldState<String> thirdName;
  final FormFieldState<String> lastName;
  final FormFieldState<String> nationalNo;
  final FormFieldState<String> dateOfBirth;

  // final FormFieldState<String> gender;
  final FormFieldState<String> phoneNumber;
  final FormFieldState<String> email;
  final FormFieldState<String> address;

  final ScreenStatus screenStatusMode;
  final SaveButtonState saveButtonStatus;
  final CountryState countryStatus;
  final RequestStatus loadPersonStatus;
  final NationalNoStatus nationalNoStatus;
  final ImagePickerStatus imagePickerStatus;

  const AddUpdateFormState({
    this.personEntity,

    this.firstName = const FormFieldState(value: ''),
    this.secondName = const FormFieldState(value: ''),
    this.thirdName = const FormFieldState(value: ''),
    this.lastName = const FormFieldState(value: ''),
    this.nationalNo = const FormFieldState(value: ''),
    this.dateOfBirth = const FormFieldState(value: ''),
    this.phoneNumber = const FormFieldState(value: ''),
    this.email = const FormFieldState(value: ''),
    this.address = const FormFieldState(value: ''),

    required this.screenStatusMode,
    required this.saveButtonStatus,
    required this.countryStatus,
    required this.loadPersonStatus,
    required this.nationalNoStatus,
    required this.imagePickerStatus,
  });

  factory AddUpdateFormState.initial({ScreenStatus mode = ScreenStatus.add}) {
    return AddUpdateFormState(
      screenStatusMode: mode,
      firstName: const FormFieldState(value: ''),
      secondName: const FormFieldState(value: ''),
      thirdName: const FormFieldState(value: ''),
      lastName: const FormFieldState(value: ''),
      nationalNo: const FormFieldState(value: ''),
      dateOfBirth: const FormFieldState(value: ''),
      phoneNumber: const FormFieldState(value: ''),
      email: const FormFieldState(value: ''),
      address: const FormFieldState(value: ''),
      saveButtonStatus: const SaveButtonState(
        saveStatus: RequestStatus.initial,
      ),
      countryStatus: const CountryState(
        loadCountryStatus: RequestStatus.initial,
      ),
      loadPersonStatus: RequestStatus.initial,
      nationalNoStatus: NationalNoStatus.initial,
      imagePickerStatus: ImagePickerStatus.initial,
    );
  }

  AddUpdateFormState copyWith({
    PeopleEntity? personEntity,

    FormFieldState<String>? firstName,
    FormFieldState<String>? secondName,
    FormFieldState<String>? thirdName,
    FormFieldState<String>? lastName,
    FormFieldState<String>? notionalNo,
    FormFieldState<String>? dateOfBirth,
    FormFieldState<String>? phoneNumber,
    FormFieldState<String>? email,
    FormFieldState<String>? address,

    ScreenStatus? screenStatusMode,
    SaveButtonState? saveButtonStatus,
    CountryState? countryStatus,
    RequestStatus? loadPersonStatus,
    NationalNoStatus? nationalNoStatus,
    ImagePickerStatus? imagePickerStatus,
  }) {
    return AddUpdateFormState(
      personEntity: personEntity ?? this.personEntity,

      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      thirdName: thirdName ?? this.thirdName,
      lastName: lastName ?? this.lastName,
      nationalNo: notionalNo ?? this.nationalNo,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,

      screenStatusMode: screenStatusMode ?? this.screenStatusMode,
      saveButtonStatus: saveButtonStatus ?? this.saveButtonStatus,
      countryStatus: countryStatus ?? this.countryStatus,
      loadPersonStatus: loadPersonStatus ?? this.loadPersonStatus,
      nationalNoStatus: nationalNoStatus ?? this.nationalNoStatus,
      imagePickerStatus: imagePickerStatus ?? this.imagePickerStatus,
    );
  }

  @override
  List<Object?> get props => [
    personEntity,
    firstName,
    secondName,
    thirdName,
    lastName,
    nationalNo,
    dateOfBirth,
    phoneNumber,
    email,
    address,
    screenStatusMode,
    saveButtonStatus,
    countryStatus,
    loadPersonStatus,
    nationalNoStatus,
    imagePickerStatus,
  ];
}
