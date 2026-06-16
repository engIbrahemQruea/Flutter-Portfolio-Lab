import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/repos/people_repos.dart';

class GetPeopleByIdUseCase extends BaseUseCase<List<PeopleEntity?>, int> {
  final PeopleRepos _repos;

  GetPeopleByIdUseCase(this._repos);

  @override
  Future<Either<Failure, List<PeopleEntity?>>> call([int? params]) async {
    return await _repos.getPeopleById(personID: params!);
  }
}
