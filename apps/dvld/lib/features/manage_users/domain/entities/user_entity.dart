// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? userID;
  final int personID;
  final String userName;
  final String password;
  final bool isActive;

  const UserEntity({
    this.userID,
    required this.personID,
    required this.userName,
    required this.password,
    required this.isActive,
  });

  @override
  List<Object?> get props => [userID, personID, userName, password, isActive];
}
