part of 'add_update_local_dr_li_application_screen_cubit.dart';

final class AddUpdateLocalDrLiApplicationScreenCubitState extends Equatable {
  const AddUpdateLocalDrLiApplicationScreenCubitState({
    // operations
    this.screenStatusMode = ScreenStatus.add,
    this.saveButtonStatus = const SaveButtonState(
      saveStatus: RequestStatus.initial,
    ),
    this.loadLocalDrLiAppInfoStatus = RequestStatus.initial,
    this.licenseClassStatus = RequestStatus.initial,

    // Data
    this.localDriLiceApplicationId,
    this.applicationDate,
    this.licenseClasses = const [],
    this.applicationFee,
    this.personSelectedId,
    this.createdByUser,
    this.userEntity,
    //Selection
    this.selectedLicenseClassId = 3,

    //UI
    this.selectedTabIndex = 0,
    this.errorMessageLicenseClass,
    this.errorMessage,
    this.isApplicationInfoEnabled = true,
    this.isSaveButtonEnabled = false,
  });

  // operations
  final ScreenStatus screenStatusMode;
  final SaveButtonState saveButtonStatus;
  final RequestStatus loadLocalDrLiAppInfoStatus;
  final RequestStatus licenseClassStatus;

  // Data
  final int? localDriLiceApplicationId;
  final DateTime? applicationDate;
  final List<LicenseClassEntity> licenseClasses;
  final double? applicationFee;
  final LoginEntity? createdByUser;
  final UserEntity? userEntity;
  final int? personSelectedId;

  //Selection
  final int selectedLicenseClassId;

  //UI
  final int selectedTabIndex;
  final bool isApplicationInfoEnabled;
  final bool isSaveButtonEnabled;

  //Error
  final String? errorMessageLicenseClass;
  final String? errorMessage;

  bool get isEditMode => screenStatusMode == ScreenStatus.update;

  bool get isAddMode => screenStatusMode == ScreenStatus.add;

  bool get hasPersonSelectedId => personSelectedId != null;

  AddUpdateLocalDrLiApplicationScreenCubitState copyWith({
    ScreenStatus? screenStatusMode,
    SaveButtonState? saveButtonStatus,
    RequestStatus? loadLocalDrLiAppInfoStatus,
    RequestStatus? licenseClassStatus,

    // Nullable Data Fields (تستخدم ValueGetter لإمكانية تمرير null)
    ValueGetter<int?>? localDriLiceApplicationId,
    ValueGetter<DateTime?>? applicationDate,
    List<LicenseClassEntity>? licenseClasses,
    ValueGetter<double?>? applicationFee,
    ValueGetter<LoginEntity?>? createdByUser,
    ValueGetter<UserEntity?>? userEntity,
    ValueGetter<int?>? personSelectedId,
    ValueGetter<String?>? errorMessageLicenseClass,
    ValueGetter<String?>? errorMessage,

    // Non-Nullable UI/Selection Fields (تستخدم القيم العادية)
    int? selectedLicenseClassId,
    int? selectedTabIndex,
    bool? isApplicationInfoEnabled,
    bool? isSaveButtonEnabled,
  }) {
    return AddUpdateLocalDrLiApplicationScreenCubitState(
      screenStatusMode: screenStatusMode ?? this.screenStatusMode,
      saveButtonStatus: saveButtonStatus ?? this.saveButtonStatus,
      loadLocalDrLiAppInfoStatus:
          loadLocalDrLiAppInfoStatus ?? this.loadLocalDrLiAppInfoStatus,
      licenseClassStatus: licenseClassStatus ?? this.licenseClassStatus,

      localDriLiceApplicationId: localDriLiceApplicationId != null
          ? localDriLiceApplicationId()
          : this.localDriLiceApplicationId,
      applicationDate: applicationDate != null
          ? applicationDate()
          : this.applicationDate,
      licenseClasses: licenseClasses ?? this.licenseClasses,
      applicationFee: applicationFee != null
          ? applicationFee()
          : this.applicationFee,
      createdByUser: createdByUser != null
          ? createdByUser()
          : this.createdByUser,
      userEntity: userEntity != null ? userEntity() : this.userEntity,
      personSelectedId: personSelectedId != null
          ? personSelectedId()
          : this.personSelectedId,
      errorMessageLicenseClass: errorMessageLicenseClass != null
          ? errorMessageLicenseClass()
          : this.errorMessageLicenseClass,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,

      selectedLicenseClassId:
          selectedLicenseClassId ?? this.selectedLicenseClassId,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      isApplicationInfoEnabled:
          isApplicationInfoEnabled ?? this.isApplicationInfoEnabled,
      isSaveButtonEnabled: isSaveButtonEnabled ?? this.isSaveButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [
    screenStatusMode,
    saveButtonStatus,
    loadLocalDrLiAppInfoStatus,
    licenseClassStatus,
    localDriLiceApplicationId,
    applicationDate,
    licenseClasses,
    applicationFee,
    createdByUser,
    userEntity,
    personSelectedId,
    selectedTabIndex,
    selectedLicenseClassId,
    errorMessageLicenseClass,
    errorMessage,
    isApplicationInfoEnabled,
    isSaveButtonEnabled,
  ];
}

//   AddUpdateLocalDrLiApplicationScreenCubitState copyWith({
//     ScreenStatus? screenStatusMode,
//     SaveButtonState? saveButtonStatus,
//     RequestStatus? loadLocalDrLiAppInfoStatus,
//     RequestStatus? licenseClassStatus,

//     ValueGetter<int?>? localDriLiceApplicationId,
//     ValueGetter<DateTime?>? applicationDate,
//     List<LicenseClassEntity>? licenseClasses,
//     ValueGetter<double>? applicationFee,
//     ValueGetter<LoginEntity>? createdByUser,
//     ValueGetter<UserEntity>? userEntity,
//     ValueGetter<int?>? personSelectedId,

//     ValueGetter<int>? selectedLicenseClassId,

//     ValueGetter<int>? selectedTabIndex,
//     ValueGetter<bool>? isApplicationInfoEnabled,
//     ValueGetter<bool>? isSaveButtonEnabled,
//     ValueGetter<String?>? errorMessageLicenseClass,
//     ValueGetter<String?>? errorMessage,
//   }) {
//     return AddUpdateLocalDrLiApplicationScreenCubitState(
//       screenStatusMode: screenStatusMode ?? this.screenStatusMode,
//       saveButtonStatus: SaveButtonState(
//         saveStatus:
//             saveButtonStatus?.saveStatus ?? this.saveButtonStatus.saveStatus,
//       ),
//       loadLocalDrLiAppInfoStatus:
//           loadLocalDrLiAppInfoStatus ?? this.loadLocalDrLiAppInfoStatus,
//       licenseClassStatus: licenseClassStatus ?? this.licenseClassStatus,

//       localDriLiceApplicationId: localDriLiceApplicationId != null
//           ? localDriLiceApplicationId()
//           : this.localDriLiceApplicationId,

//       applicationDate: applicationDate != null
//           ? applicationDate()
//           : this.applicationDate,

//       licenseClasses: licenseClasses ?? this.licenseClasses,
//       applicationFee: applicationFee != null
//           ? applicationFee()
//           : this.applicationFee,

//       createdByUser: createdByUser != null ? createdByUser() : this.createdByUser,

//       userEntity: userEntity != null ? userEntity() : this.userEntity,

//       selectedTabIndex: selectedTabIndex != null
//           ? selectedTabIndex()
//           : this.selectedTabIndex,

//       selectedLicenseClassId: selectedLicenseClassId != null
//           ? selectedLicenseClassId()
//           : this.selectedLicenseClassId,

//       isApplicationInfoEnabled: isApplicationInfoEnabled != null
//           ? isApplicationInfoEnabled()
//           : this.isApplicationInfoEnabled,

//       errorMessageLicenseClass: errorMessageLicenseClass != null
//           ? errorMessageLicenseClass()
//           : this.errorMessageLicenseClass,

//       errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,

//       personSelectedId: personSelectedId != null
//           ? personSelectedId()
//           : this.personSelectedId,

//       isSaveButtonEnabled: isSaveButtonEnabled != null
//           ? isSaveButtonEnabled()
//           : this.isSaveButtonEnabled,
//     );
//   }

//   @override
//   List<Object?> get props => [
//     screenStatusMode,
//     saveButtonStatus,
//     loadLocalDrLiAppInfoStatus,
//     licenseClassStatus,

//     localDriLiceApplicationId,
//     applicationDate,
//     licenseClasses,
//     applicationFee,
//     createdByUser,
//     userEntity,

//     selectedTabIndex,
//     selectedLicenseClassId,
//     errorMessageLicenseClass,
//     isApplicationInfoEnabled,
//     personSelectedId,
//     isSaveButtonEnabled,
//   ];
// }
