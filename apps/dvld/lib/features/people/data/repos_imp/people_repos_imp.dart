// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/local_data_source.dart';
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
      return Left(Failure());
    }
  }
}
