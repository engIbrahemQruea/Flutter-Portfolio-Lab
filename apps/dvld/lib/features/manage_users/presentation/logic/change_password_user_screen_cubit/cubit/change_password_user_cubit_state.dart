part of 'change_password_user_cubit.dart';

final class ChangePasswordUserCubitState extends Equatable {
  const ChangePasswordUserCubitState({
    this.saveButtonChangePasswordStatus = const SaveButtonState(
      saveStatus: RequestStatus.initial,
    ),
    this.user,
    this.currentPassword = const FormFieldState<String>(value: ''),
    this.newPassword = const FormFieldState<String>(value: ''),
    this.confirmPassword = const FormFieldState<String>(value: ''),
  });

  final SaveButtonState saveButtonChangePasswordStatus;
  final UserEntity? user;
  final FormFieldState<String> currentPassword;
  final FormFieldState<String> newPassword;
  final FormFieldState<String> confirmPassword;

  bool get isMatchPassword => newPassword.value == confirmPassword.value;
  bool get isFormValid =>
      currentPassword.isValid &&
      newPassword.isValid &&
      confirmPassword.isValid &&
      isMatchPassword;

  ChangePasswordUserCubitState copyWith({
    SaveButtonState? saveButtonChangePasswordStatus,
    UserEntity? user,
    FormFieldState<String>? currentPassword,
    FormFieldState<String>? newPassword,
    FormFieldState<String>? confirmPassword,
  }) {
    return ChangePasswordUserCubitState(
      saveButtonChangePasswordStatus:
          saveButtonChangePasswordStatus ?? this.saveButtonChangePasswordStatus,
      user: user ?? this.user,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
    saveButtonChangePasswordStatus,
    user,
    currentPassword,
    newPassword,
    confirmPassword,
  ];
}
