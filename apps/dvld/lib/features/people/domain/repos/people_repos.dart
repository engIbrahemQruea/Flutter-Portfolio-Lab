import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
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
}
