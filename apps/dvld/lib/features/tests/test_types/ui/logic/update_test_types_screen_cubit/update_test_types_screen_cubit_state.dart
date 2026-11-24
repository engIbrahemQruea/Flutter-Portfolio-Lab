part of 'update_test_types_screen_cubit.dart';

final class UpdateTestTypesScreenCubitState extends Equatable {
  const UpdateTestTypesScreenCubitState({
    this.loadTestTypesStatus = RequestStatus.initial,
    this.saveButtonStatusTestTypes = const SaveButtonState(
      saveStatus: RequestStatus.initial,
    ),
    this.testTypeId,
    this.testTypeTitle = const TestTypeTitleInput.pure(),
    this.testTypeDescription = const TestTypeDescriptionInput.pure(),
    this.testTypeFee = const TestTypeFeesInput.pure(),
    this.errorMessage = '',
  });

  final RequestStatus loadTestTypesStatus;
  final SaveButtonState saveButtonStatusTestTypes;
  final int? testTypeId;
  final TestTypeTitleInput testTypeTitle;
  final TestTypeDescriptionInput testTypeDescription;
  final TestTypeFeesInput testTypeFee;
  final String errorMessage;

  bool get isFormValid =>
      Formz.validate([testTypeTitle, testTypeDescription, testTypeFee]);

  UpdateTestTypesScreenCubitState copyWith({
    RequestStatus? loadTestTypesStatus,
    SaveButtonState? saveButtonStatusTestTypes,
    ValueGetter<int?>? testTypeId,
    TestTypeTitleInput? testTypeTitle,
    TestTypeDescriptionInput? testTypeDescription,
    TestTypeFeesInput? testTypeFee,
    ValueGetter<String>? errorMessage,
  }) => UpdateTestTypesScreenCubitState(
    loadTestTypesStatus: loadTestTypesStatus ?? this.loadTestTypesStatus,
    saveButtonStatusTestTypes:
        saveButtonStatusTestTypes ?? this.saveButtonStatusTestTypes,
    testTypeId: testTypeId != null ? testTypeId() : this.testTypeId,
    testTypeTitle: testTypeTitle ?? this.testTypeTitle,
    testTypeDescription: testTypeDescription ?? this.testTypeDescription,
    testTypeFee: testTypeFee ?? this.testTypeFee,
    errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
  );

  @override
  List<Object?> get props => [
    loadTestTypesStatus,
    saveButtonStatusTestTypes,
    testTypeId,
    testTypeTitle,
    testTypeDescription,
    testTypeFee,
    errorMessage,
  ];
}
