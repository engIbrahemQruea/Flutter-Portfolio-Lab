import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';

abstract class PeopleRepos {
  Future<Either<Failure, List<PeopleEntity>>> getListPeople();
}
