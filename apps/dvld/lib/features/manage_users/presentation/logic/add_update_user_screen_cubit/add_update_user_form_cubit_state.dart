part of 'add_update_user_form_cubit.dart';

enum NextButtonStatus {
  initial,
  checking,
  exist,
  personNotSelected,
  notExist,
  failure;

  bool get isChecking => this == NextButtonStatus.checking;
  bool get isExist => this == NextButtonStatus.exist;
  bool get isNotExist => this == NextButtonStatus.notExist;
}

final class AddUpdateUserFormCubitState extends Equatable {
  const AddUpdateUserFormCubitState({
    this.screenStatusMode = ScreenStatus.add,
    this.nextButtonStatus = NextButtonStatus.initial,
    this.loadUserStatus = RequestStatus.initial,
    this.selectedTabIndex = 0,
    this.userId,
    this.personId,
    this.userName = const FormFieldState<String>(value: ''),
    this.password = const FormFieldState<String>(value: ''),
    this.confirmPassword = const FormFieldState<String>(value: ''),
    this.isActive = true,
    this.isEnabledTab = true,
    this.saveButtonStatus = const SaveButtonState(
      saveStatus: RequestStatus.initial,
    ),
  });

  final ScreenStatus screenStatusMode;
  final NextButtonStatus nextButtonStatus;
  final RequestStatus loadUserStatus;
  final int selectedTabIndex;
  final int? userId;
  final int? personId;
  final FormFieldState<String> userName;
  final FormFieldState<String> password;
  final FormFieldState<String> confirmPassword;
  final bool isActive;
  final bool isEnabledTab;
  final SaveButtonState saveButtonStatus;

  bool get isEditMode => screenStatusMode == ScreenStatus.update;
  bool get isMatchPassword => password.value == confirmPassword.value;
  bool get isFormValid =>
      userName.isValid &&
      password.isValid &&
      confirmPassword.isValid &&
      isMatchPassword;

  AddUpdateUserFormCubitState copyWith({
    ScreenStatus? screenStatusMode,
    NextButtonStatus? nextButtonStatus,
    RequestStatus? loadUserStatus,
    int? selectedTabIndex,
    int? Function()? userId,
    int? Function()? personId,
    FormFieldState<String>? userName,
    FormFieldState<String>? password,
    FormFieldState<String>? confirmPassword,
    bool? isActive,
    bool? isEnabledTab,
    SaveButtonState? saveButtonStatus,
  }) {
    return AddUpdateUserFormCubitState(
      screenStatusMode: screenStatusMode ?? this.screenStatusMode,
      nextButtonStatus: nextButtonStatus ?? this.nextButtonStatus,
      loadUserStatus: loadUserStatus ?? this.loadUserStatus,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      userId: userId != null ? userId() : this.userId,
      personId: personId != null ? personId() : this.personId,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isActive: isActive ?? this.isActive,
      isEnabledTab: isEnabledTab ?? this.isEnabledTab,
      saveButtonStatus: saveButtonStatus ?? this.saveButtonStatus,
    );
  }

  @override
  List<Object?> get props => [
    screenStatusMode,
    nextButtonStatus,
    loadUserStatus,
    selectedTabIndex,
    userId,
    personId,
    userName,
    password,
    confirmPassword,
    isActive,
    isEnabledTab,
    saveButtonStatus,
  ];
}
