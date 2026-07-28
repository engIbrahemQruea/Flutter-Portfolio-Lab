// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';

class UserModel extends DataMapper<UserEntity> {
  final int? userID;
  final int personID;
  final String userName;
  final String password;
  final bool isActive;

  UserModel({
    this.userID,
    required this.personID,
    required this.userName,
    required this.password,
    required this.isActive,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map[UserTable.colUserId] as int?,
      personID: map[UserTable.colPersonId] as int,
      userName: map[UserTable.colUserName] as String,
      password: map[UserTable.colPassword] as String,
      isActive: (map[UserTable.colIsActive] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (userID != null) UserTable.colUserId: userID,
      UserTable.colPersonId: personID,
      UserTable.colUserName: userName,
      UserTable.colPassword: password,
      UserTable.colIsActive: isActive ? 1 : 0,
    };
  }

  @override
  UserEntity mapToEntity() {
    return UserEntity(
      userID: userID,
      personID: personID,
      userName: userName,
      password: password,
      isActive: isActive,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      userID: entity.userID,
      personID: entity.personID,
      userName: entity.userName,
      password: entity.password,
      isActive: entity.isActive,
    );
  }
}
