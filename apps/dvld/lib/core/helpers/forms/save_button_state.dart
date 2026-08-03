import 'package:dvld/core/helpers/forms/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SaveButtonState extends Equatable {
  final RequestStatus saveStatus;
  final String? errorMessage;

  const SaveButtonState({required this.saveStatus, this.errorMessage});

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
