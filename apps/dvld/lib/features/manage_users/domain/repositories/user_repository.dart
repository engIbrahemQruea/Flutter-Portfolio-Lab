import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getAllUsers();

  Future<Either<Failure, UserEntity?>> getUserInfoByUserID({required int userID});
  Future<Either<Failure, UserEntity?>> getUserInfoByPersonID({required int personID});
  Future<Either<Failure, UserEntity?>> getUserInfoByUserName({required String userName});
  Future<Either<Failure, UserEntity?>> getUserInfoByPassword({required String password});
  Future<Either<Failure, bool>>isUserExistForPersonID({required int personID});
  Future<Either<Failure,UserEntity?>>addNewUser({required UserEntity userEntity});
  Future<Either<Failure,UserEntity?>>updateUser({required UserEntity userEntity});
}
