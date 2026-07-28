import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/manage_users/data/datasources/user_local_data_source.dart';
import 'package:dvld/features/manage_users/data/models/user_model.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/manage_users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userLocalDataSource);

  final UserLocalDataSource _userLocalDataSource;

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final users = await _userLocalDataSource.getAllUsers();
      final userListModel = users.map((e) => UserModel.fromMap(e));
      final userListEntity = userListModel.map((e) => e.mapToEntity()).toList();

      // final userListEntity = users
      //     .map((e) => UserModel.fromMap(e).mapToEntity())
      //     .toList();

      return Right(userListEntity);
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserInfoByPersonID({
    required int personID,
  }) async {
    try {
      final userInfo = await _userLocalDataSource.getUserInfoByPersonID(
        personID: personID,
      );
      return Right(
        userInfo != null ? UserModel.fromMap(userInfo).mapToEntity() : null,
      );
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserInfoByUserID({
    required int userID,
  }) async {
    try {
      final userInfo = await _userLocalDataSource.getUserInfoById(
        userID: userID,
      );
      return Right(
        userInfo != null ? UserModel.fromMap(userInfo).mapToEntity() : null,
      );
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserInfoByUserName({
    required String userName,
  }) async {
    try {
      final userInfo = await _userLocalDataSource.getUserInfoByUserName(
        userName: userName,
      );
      return Right(
        userInfo != null ? UserModel.fromMap(userInfo).mapToEntity() : null,
      );
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getUserInfoByPassword({
    required String password,
  }) async {
    try {
      final userInfo = await _userLocalDataSource.getUserInfoByPassword(
        password: password,
      );
      return Right(
        userInfo != null ? UserModel.fromMap(userInfo).mapToEntity() : null,
      );
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
