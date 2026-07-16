
import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/domain/repos/people_repos.dart';

class IsNationalNoExistsUseCase extends BaseUseCase<bool, String> {
  IsNationalNoExistsUseCase(this._repos);
 final PeopleRepos _repos;


  @override
  Future<Either<Failure, bool>> call([String? params]) async {
    return await _repos.isNationalNoExists(nationalNo: params!);
  }
}