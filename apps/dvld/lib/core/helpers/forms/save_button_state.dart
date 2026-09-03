import 'package:dvld/core/helpers/forms/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class SaveButtonState extends Equatable {
  final RequestStatus saveStatus;
  final String? errorMessage;

  const SaveButtonState({
    this.saveStatus = RequestStatus.initial,
    this.errorMessage,
  });

  const SaveButtonState.initial() : this(saveStatus: RequestStatus.initial);

  const SaveButtonState.loading() : this(saveStatus: RequestStatus.loading);

  const SaveButtonState.success() : this(saveStatus: RequestStatus.success);

  const SaveButtonState.failure([String? errorMessage])
    : this(saveStatus: RequestStatus.failure, errorMessage: errorMessage);

  // Getters
  bool get isInitial => saveStatus == RequestStatus.initial;
  bool get isLoading => saveStatus == RequestStatus.loading;
  bool get isSuccess => saveStatus == RequestStatus.success;
  bool get isFailure => saveStatus == RequestStatus.failure;

  SaveButtonState copyWith({
    RequestStatus? saveStatus,
    ValueGetter<String?>? errorMessage,
  }) {
    return SaveButtonState(
      saveStatus: saveStatus ?? this.saveStatus,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [saveStatus, errorMessage];
}

// import 'package:dvld/core/helpers/forms/enums.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// class SaveButtonState extends Equatable {
//   final RequestStatus saveStatus;
//   final String? errorMessage;

//   const SaveButtonState({required this.saveStatus, this.errorMessage});

//   bool get isLoading => saveStatus == RequestStatus.loading;
//   bool get isSuccess => saveStatus == RequestStatus.success;
//   bool get isFailure => saveStatus == RequestStatus.failure;

//   SaveButtonState copyWith({
//     RequestStatus? saveStatus,
//     ValueGetter<String?>? errorMessage,
//   }) {
//     return SaveButtonState(
//       saveStatus: saveStatus ?? this.saveStatus,
//       errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [saveStatus, errorMessage];
// }
