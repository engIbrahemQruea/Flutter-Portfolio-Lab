import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:equatable/equatable.dart';

class LoginModel extends DataMapper<LoginEntity> with Equatable {
  final int? userId;
  final int? personId;
  final String userName;
  final String password;
  final bool isActive;

  LoginModel({
    this.userId,
    this.personId,
    required this.userName,
    required this.password,
    required this.isActive,
  });

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      userId: map[UserTable.colUserId] as int?,
      personId: map[UserTable.colPersonId] as int,
      userName: map[UserTable.colUserName] as String,
      password: map[UserTable.colPassword] as String,
      isActive: (map[UserTable.colIsActive] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      UserTable.colUserId: userId,
      UserTable.colPersonId: personId,
      UserTable.colUserName: userName,
      UserTable.colPassword: password,
      UserTable.colIsActive: isActive ? 1 : 0,
    };
  }

  factory LoginModel.fromEntity(LoginEntity entity) {
    return LoginModel(
      userId: entity.userId,
      personId: entity.personId,
      userName: entity.userName,
      password: entity.password,
      isActive: entity.isActive,
    );
  }

  @override
  LoginEntity mapToEntity() => LoginEntity(
    userId: userId,
    personId: personId,
    userName: userName,
    password: password,
    isActive: isActive,
  );

  @override
  List<Object?> get props => [userId, personId, userName, password, isActive];
}
