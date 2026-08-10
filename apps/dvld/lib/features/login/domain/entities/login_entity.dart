import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final int? userId;
  final int? personId;
  final String userName;
  final String password;
  final bool isActive;

  const LoginEntity({
    this.userId,
    this.personId,
    required this.userName,
    required this.isActive,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, personId, userName, isActive, password];
}
