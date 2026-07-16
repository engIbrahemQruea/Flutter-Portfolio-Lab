import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/domain/entities/county_entity.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';

abstract class PeopleRepos {
  Future<Either<Failure, List<PeopleEntity>>> getListPeople();
  Future<Either<Failure, List<PeopleEntity?>>> getPeopleById({
    required int personID,
  });
  Future<Either<Failure, List<PeopleEntity?>>> getPeopleByNationalNo({
    required String nationalNo,
  });
  Future<Either<Failure, List<PeopleEntity?>>> getPeopleByFirstName({
    required String firstName,
  });

  /// Add Update Screen
  Future<Either<Failure, bool>> addPeople({required PeopleEntity peopleEntity});

Future<Either<Failure, PeopleEntity?>> getInfoPeopleById({required int personID});

  Future<Either<Failure, bool>> updatePeople({required PeopleEntity peopleEntity});

  Future<Either<Failure, bool>> isNationalNoExists({required String nationalNo});

/// Country Repos
Future<Either<Failure, List<CountyEntity>>> getAllCountries();
Future<Either<Failure, String?>> getCountryNameById({required int countryId});
Future<Either<Failure, int?>> getCountryIdByName({required String countryName});
}
