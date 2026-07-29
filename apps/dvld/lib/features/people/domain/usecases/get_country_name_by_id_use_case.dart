import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/people/domain/repos/people_repos.dart';

class GetCountryNameByIdUseCase extends BaseUseCase<String?, int> {
  GetCountryNameByIdUseCase(this._repos);
  final PeopleRepos _repos;

  @override
  Future<Either<Failure, String?>> call([int? params]) async =>
      await _repos.getCountryNameById(countryId: params!);
}
