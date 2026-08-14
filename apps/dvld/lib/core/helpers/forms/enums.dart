enum ScreenStatus { add, update }

enum RequestStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == RequestStatus.loading;
  bool get isSuccess => this == RequestStatus.success;
  bool get isFailure => this == RequestStatus.failure;
}
