import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/domain/repos/people_repos.dart';

class UpdatePeopleUseCase extends BaseUseCase<bool, PeopleEntity> {
  final PeopleRepos _repos;

  UpdatePeopleUseCase(this._repos);

  @override
  Future<Either<Failure, bool>> call([PeopleEntity? params]) async {
    return await _repos.updatePeople(peopleEntity: params!);
  }
}
