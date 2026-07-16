// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/local_data_source.dart';
import 'package:dvld/features/people/data/models/people_models.dart';
import 'package:dvld/features/people/domain/entities/county_entity.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/repos/people_repos.dart';

class PeopleReposImp extends PeopleRepos {
  final DatabaseHelper _dbHelper;
  PeopleReposImp(this._dbHelper);
  @override
  Future<Either<Failure, List<PeopleEntity>>> getListPeople() async {
    try {
      final peopleListModels = await _dbHelper.getListPeople();
      return Right(
        peopleListModels.map((model) => model.mapToEntity()).toList(),
      );
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeopleEntity?>>> getPeopleByFirstName({
    required String firstName,
  }) async {
    try {
      final peopleResult = await _dbHelper.getPeopleByFirstName(
        firstName: firstName,
      );
      if (peopleResult.isNotEmpty) {
        return Right(
          peopleResult.map((model) => model!.mapToEntity()).toList(),
        );
      } else {
        return Right([null]);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeopleEntity?>>> getPeopleById({
    required int personID,
  }) async {
    try {
      final peopleResult = await _dbHelper.getPeopleById(personID: personID);
      if (peopleResult.isNotEmpty) {
        return Right(
          peopleResult.map((model) => model!.mapToEntity()).toList(),
        );
      } else {
        return Right([null]);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeopleEntity?>>> getPeopleByNationalNo({
    required String nationalNo,
  }) async {
    try {
      final peopleResult = await _dbHelper.getPeopleByNationalNo(
        nationalNo: nationalNo,
      );
      if (peopleResult.isNotEmpty) {
        return Right(
          peopleResult.map((model) => model!.mapToEntity()).toList(),
        );
      } else {
        return Right([null]);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addPeople({
    required PeopleEntity peopleEntity,
  }) async {
    try {
      final peopleModel = PeopleModels.fromEntity(peopleEntity);
      final newPeopleId = await _dbHelper.addNewPeople(peopleModel);

      return Right(newPeopleId >= 0);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePeople({
    required PeopleEntity peopleEntity,
  }) async {
    try {
      final peopleModel = PeopleModels.fromEntity(peopleEntity);
      final isUpdated = await _dbHelper.updatePeople(peopleModel);
      return Right(isUpdated >= 0);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PeopleEntity?>> getInfoPeopleById({
    required int personID,
  }) async {
    try {
      final peopleResult = await _dbHelper.getPeopleById(personID: personID);
      if (peopleResult.isNotEmpty) {
        return Right(peopleResult[0]!.mapToEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isNationalNoExists({
    required String nationalNo,
  }) async {
    try {
      final isExists = await _dbHelper.isNationalNoExists(
        nationalNo: nationalNo,
      );
      return Right(isExists);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Country Repo Impl

  @override
  Future<Either<Failure, List<CountyEntity>>> getAllCountries() async {
    try {
      final listModelCountries = await _dbHelper.getAllCountries();
      return Right(
        listModelCountries.map((model) => model.mapToEntity()).toList(),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int?>> getCountryIdByName({
    required String countryName,
  }) async {
    try {
      final countryID = await _dbHelper.getCountryIdByName(
        countryName: countryName,
      );
      return Right(countryID);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getCountryNameById({
    required int countryId,
  }) async {
    try {
      final countryName = await _dbHelper.getCountryNameById(
        countryId: countryId,
      );
      return Right(countryName);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
