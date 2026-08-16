part of 'update_application_types_screen_cubit.dart';

final class UpdateApplicationTypesScreenCubitState extends Equatable {
  const UpdateApplicationTypesScreenCubitState({
    this.loadApplicationTypesStatus = RequestStatus.initial,
    this.saveButtonStatus = const SaveButtonState(
      saveStatus: RequestStatus.initial,
    ),
    this.applicationTypeId,
    this.applicationTypeTitle = const FormFieldState(value: ''),
    this.applicationTypeFee = const FormFieldState(value: ''),
    this.errorMessage,
  });

  final RequestStatus loadApplicationTypesStatus;
  final SaveButtonState saveButtonStatus;
  final int? applicationTypeId;
  final FormFieldState<String> applicationTypeTitle;
  final FormFieldState<String> applicationTypeFee;
  final String? errorMessage;

  bool get isFormValid =>
      applicationTypeTitle.isValid && applicationTypeFee.isValid;

  bool get isSubmitting => saveButtonStatus.saveStatus == RequestStatus.loading;

  UpdateApplicationTypesScreenCubitState copyWith({
    RequestStatus? loadApplicationTypesStatus,
    SaveButtonState? saveButtonStatus,
    ValueGetter<int?>? applicationTypeId,
    FormFieldState<String>? applicationTypeTitle,
    FormFieldState<String>? applicationTypeFee,
    ValueGetter<String?>? errorMessage,
  }) {
    return UpdateApplicationTypesScreenCubitState(
      loadApplicationTypesStatus:
          loadApplicationTypesStatus ?? this.loadApplicationTypesStatus,
      saveButtonStatus: saveButtonStatus ?? this.saveButtonStatus,
      applicationTypeId: applicationTypeId != null
          ? applicationTypeId()
          : this.applicationTypeId,
      applicationTypeTitle: applicationTypeTitle ?? this.applicationTypeTitle,
      applicationTypeFee: applicationTypeFee ?? this.applicationTypeFee,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loadApplicationTypesStatus,
    saveButtonStatus,
    applicationTypeId,
    applicationTypeTitle,
    applicationTypeFee,
    errorMessage,
  ];
}
