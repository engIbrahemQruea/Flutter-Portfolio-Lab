import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/features/manage_users/data/datasources/user_local_data_source.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:dvld/features/manage_users/data/repositoriesImp/user_repository_impl.dart';
import 'package:dvld/features/manage_users/domain/repositories/user_repository.dart';
import 'package:dvld/features/manage_users/domain/usecases/add_new_user_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/change_user_password_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/delete_user_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_all_users_usecase.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_password_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_person_id_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_user_id_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_user_name_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/is_user_exist_for_person_id_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/update_user_use_case.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:dvld/features/manage_users/presentation/logic/change_password_user_screen_cubit/cubit/change_password_user_cubit.dart';
import 'package:dvld/features/manage_users/presentation/logic/cubit/manage_users_cubit.dart';
import 'package:dvld/features/manage_users/presentation/logic/user_information_card_cubit/user_information_card_cubit.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/local_data_source.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/people_table.dart';
import 'package:dvld/features/people/data/repos_imp/people_repos_imp.dart';
import 'package:dvld/features/people/domain/repos/people_repos.dart';
import 'package:dvld/features/people/domain/usecases/add_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/delete_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_country_name_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_info_by_national_no_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_list_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_first_name_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_national_no_use_case.dart';
import 'package:dvld/features/people/domain/usecases/is_national_no_exists_use_case.dart';
import 'package:dvld/features/people/domain/usecases/update_people_use_case.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/cubit/get_all_people_cubit.dart';
import 'package:dvld/features/people/presentation/person_details_screen/logic/person_details_cubit/person_details_cubit.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final appDatabase = AppDatabase();

  appDatabase.registerTable(PeopleTable());

  getIt.registerSingleton<AppDatabase>(appDatabase);
  getIt.registerLazySingleton<PeopleLocalDataSource>(
    () => PeopleLocalDataSource(getIt()),
  );

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
  getIt.registerLazySingleton(() => GetCountryNameByIdUseCase(getIt()));

  getIt.registerLazySingleton<PeopleReposImp>(() => PeopleReposImp(getIt()));
  getIt.registerLazySingleton<AddUpdateFormCubit>(
    () => AddUpdateFormCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  /// Person Details Screen
  getIt.registerFactory<PersonDetailsCubit>(
    () => PersonDetailsCubit(getIt(), getIt()),
  );

  /// Person Selector Composition Widget
  getIt.registerLazySingleton(() => GetInfoByNationalNoUseCase(getIt()));
  getIt.registerFactory<PersonSelectorCubit>(
    () => PersonSelectorCubit(getIt(), getIt(), getIt()),
  );

  /// Manage Users Features/Screens

  appDatabase.registerTable(UserTable());

  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(getIt()),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetAllUsersUseCase(getIt()));

  getIt.registerLazySingleton(() => GetUserInfoByUserIdUseCase(getIt()));

  getIt.registerLazySingleton(() => GetUserInfoByPersonIdUseCase(getIt()));

  getIt.registerLazySingleton(() => GetUserInfoByUserNameUseCase(getIt()));

  getIt.registerLazySingleton(() => GetUserInfoByPasswordUseCase(getIt()));

  getIt.registerLazySingleton(() => IsUserExistForPersonIdUseCase(getIt()));

  getIt.registerLazySingleton(() => AddNewUserUseCase(getIt()));

  getIt.registerLazySingleton(() => UpdateUserUseCase(getIt()));

  getIt.registerLazySingleton(() => DeleteUserUseCase(getIt()));

  getIt.registerLazySingleton(() => ChangeUserPasswordUseCase(getIt()));

  getIt.registerFactory<ManageUsersCubit>(
    () => ManageUsersCubit(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  /// Add Update User Screen
  getIt.registerFactory<AddUpdateUserFormCubit>(
    () => AddUpdateUserFormCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  /// Show Details User Screen
  getIt.registerFactory<UserInformationCardCubit>(
    () => UserInformationCardCubit(getIt(), getIt(), getIt()),
  );

  /// Change Password User Screen
  getIt.registerFactory<ChangePasswordUserCubit>(
    () => ChangePasswordUserCubit(getIt()),
  );
}
