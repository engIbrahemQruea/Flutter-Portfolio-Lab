import 'package:dvld/features/people/data/data_sources/local_data_sources/local_data_source.dart';
import 'package:dvld/features/people/data/repos_imp/people_repos_imp.dart';
import 'package:dvld/features/people/domain/repos/people_repos.dart';
import 'package:dvld/features/people/domain/usecases/add_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/delete_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_list_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_first_name_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_national_no_use_case.dart';
import 'package:dvld/features/people/domain/usecases/is_national_no_exists_use_case.dart';
import 'package:dvld/features/people/domain/usecases/update_people_use_case.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/cubit/get_all_people_cubit.dart';
import 'package:dvld/features/people/presentation/person_details_screen/logic/person_details_cubit/person_details_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // People Feature
  // getDataSources
  // await DatabaseHelper().database;
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  getIt.registerLazySingleton<PeopleRepos>(() => PeopleReposImp(getIt()));
  getIt.registerLazySingleton(() => GetListPeopleUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPeopleByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPeopleByNationalNoUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPeopleByFirstNameUseCase(getIt()));
  getIt.registerLazySingleton(() => DeletePeopleUseCase(getIt()));
  getIt.registerLazySingleton<GetAllPeopleCubit>(
    () => GetAllPeopleCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  /// Add Update Screen
  getIt.registerLazySingleton(() => AddPeopleUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdatePeopleUseCase(getIt()));
  getIt.registerLazySingleton(() => GetInfoByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => IsNationalNoExistsUseCase(getIt()));
  // getIt.registerLazySingleton<AddUpdateScreenCubit>(
  //   () => AddUpdateScreenCubit(getIt(), getIt(), getIt()),
  // );

  getIt.registerLazySingleton<PeopleReposImp>(() => PeopleReposImp(getIt()));
  getIt.registerLazySingleton<AddUpdateFormCubit>(
    () => AddUpdateFormCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  /// Person Details Screen
  getIt.registerFactory<PersonDetailsCubit>(() => PersonDetailsCubit(getIt()));
}
