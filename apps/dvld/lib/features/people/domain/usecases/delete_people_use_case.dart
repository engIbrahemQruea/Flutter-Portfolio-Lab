
import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/domain/repos/people_repos.dart';

class DeletePeopleUseCase extends BaseUseCase<bool, int> {
  final PeopleRepos repos;
  DeletePeopleUseCase(this.repos);

  @override
  Future<Either<Failure, bool>> call([int? params]) async {
    return await repos.deletePeople(personID: params!);
  }
}