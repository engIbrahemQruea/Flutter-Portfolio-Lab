part of 'take_test_cubit.dart';

enum TakeTestStatus {
  initial,
  loading,
  loaded,
  failure,
  success;

  bool get isInitial => this == TakeTestStatus.initial;
  bool get isLoading => this == TakeTestStatus.loading;
  bool get isLoaded => this == TakeTestStatus.loaded;
  bool get isFailure => this == TakeTestStatus.failure;
  bool get isSuccess => this == TakeTestStatus.success;
}

final class TakeTestCubitState extends Equatable {
  const TakeTestCubitState({
    this.takeTestStatus = TakeTestStatus.initial,
     this.takeTestInfoEntity,
    this.selectedResultTest = false,
    this.isLucked = false,
    this.notes,
    this.errorMessage,
  });

  final TakeTestStatus takeTestStatus;
  final TakeTestInfoReadEntity? takeTestInfoEntity;
  final bool selectedResultTest;
  final bool isLucked;
  final String? notes;
  final String? errorMessage;

  TakeTestCubitState copyWith({
    TakeTestStatus? takeTestStatus,
    TakeTestInfoReadEntity? takeTestInfoEntity,
    bool? selectedResultTest,
    bool? isLucked,
    String? notes,
    String? errorMessage,
  }) {
    return TakeTestCubitState(
      takeTestStatus: takeTestStatus ?? this.takeTestStatus,
      takeTestInfoEntity: takeTestInfoEntity ?? this.takeTestInfoEntity,
      selectedResultTest: selectedResultTest ?? this.selectedResultTest,
      isLucked: isLucked ?? this.isLucked,
      notes: notes ?? this.notes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    takeTestStatus,
    takeTestInfoEntity,
    selectedResultTest,
    isLucked,
    notes,
    errorMessage,
  ];
}

// final class TakeTestCubitInitial extends TakeTestCubitState {}

// final class TakeTestCubitLoading extends TakeTestCubitState {}

// final class TakeTestCubitLoaded extends TakeTestCubitState {
//   final TakeTestInfoReadEntity takeTestInfoEntity;

//   const TakeTestCubitLoaded(this.takeTestInfoEntity);
// }

// final class TakeTestCubitFailure extends TakeTestCubitState {
//   final String message;
//   const TakeTestCubitFailure(this.message);
// }

// final class TakeTestCubitSavedSuccessfully extends TakeTestCubitState {}
