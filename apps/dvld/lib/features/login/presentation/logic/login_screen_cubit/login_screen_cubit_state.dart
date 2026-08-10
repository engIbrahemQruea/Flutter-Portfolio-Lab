part of 'login_screen_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  inactiveAccount,
  loadedCredentials,
  failure;

  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isInactiveAccount => this == LoginStatus.inactiveAccount;
  bool get isLoadedCredentials => this == LoginStatus.loadedCredentials;
  bool get isFailure => this == LoginStatus.failure;
}

final class LoginScreenCubitState extends Equatable {
  const LoginScreenCubitState({
    this.loginStatus = LoginStatus.initial,
    this.userEntity,
    this.isRememberMe = false,
    this.errorMessage,
  });

  final LoginStatus loginStatus;
  final LoginEntity? userEntity;
  final bool? isRememberMe;
  final String? errorMessage;

  LoginScreenCubitState copyWith({
    LoginStatus? loginStatus,
    LoginEntity? Function()? userEntity,
    bool? Function()? isRememberMe,
    String? Function()? errorMessage,
  }) => LoginScreenCubitState(
    loginStatus: loginStatus ?? this.loginStatus,
    userEntity: userEntity != null ? userEntity() : this.userEntity,
    isRememberMe: isRememberMe != null ? isRememberMe() : this.isRememberMe,
    errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
  );

  @override
  List<Object> get props => [
    loginStatus,
    userEntity ?? '',
    isRememberMe ?? false,
    errorMessage ?? '',
  ];
}
