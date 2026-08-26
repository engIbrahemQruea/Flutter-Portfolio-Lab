import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/helpers/shared_pref_helper.dart';
import 'package:dvld/features/applications/application_types/data/data_sources/application_type_table.dart';
import 'package:dvld/features/applications/application_types/data/index_data_application_type.dart';
import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/applications/application_types/ui/logic/application_types_screen_cubit/application_types_screen_cubit.dart';
import 'package:dvld/features/applications/application_types/ui/logic/update_application_types_screen_cubit/update_application_types_screen_cubit.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/data/repositories_impl/applications_repository_impl.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';
import 'package:dvld/features/applications/applications_core/domain/use_cases/index_app_core_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_local_data_source.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_view_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/test_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/repository_impl/local_driving_license_application_repository_impl.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/get_all_license_classes_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:dvld/features/applications/test_types/data/data_sources/test_type_table.dart';
import 'package:dvld/features/applications/test_types/data/index_data_test_type.dart';
import 'package:dvld/features/applications/test_types/ui/logic/index_test_type_cubit.dart';
import 'package:dvld/features/login/data/datasources/login_local_data_source.dart';
import 'package:dvld/features/login/data/login_repository_impl/login_repository_impl.dart';
import 'package:dvld/features/login/domain/login_repository/login_repository.dart';
import 'package:dvld/features/login/domain/login_use_cases/get_data_shared_pref_use_case.dart';
import 'package:dvld/features/login/domain/login_use_cases/login_use_case.dart';
import 'package:dvld/features/login/presentation/logic/login_screen_cubit/login_screen_cubit.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final appDatabase = AppDatabase();

  appDatabase.registerTable(PeopleTable());

  getIt.registerSingleton<AppDatabase>(appDatabase);

  /// Shared Preferences Helper Class
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPrefHelper>(
    () => SharedPrefHelper(sharedPreferences),
  );

  /// Login Screen
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSource(appDatabase: getIt()),
  );
  getIt.registerLazySingleton(() => LoginUseCase(loginRepository: getIt()));
  getIt.registerFactory<LoginScreenCubit>(
    () => LoginScreenCubit(getIt(), getIt()),
  );

  /// People Screen
  getIt.registerLazySingleton<PeopleRepos>(() => PeopleReposImp(getIt()));
  getIt.registerLazySingleton<PeopleLocalDataSource>(
    () => PeopleLocalDataSource(getIt()),
  );
  getIt.registerLazySingleton(() => GetListPeopleUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPeopleByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPeopleByNationalNoUseCase(getIt()));
  getIt.registerLazySingleton(() => GetPeopleByFirstNameUseCase(getIt()));
  getIt.registerLazySingleton(() => DeletePeopleUseCase(getIt()));
  getIt.registerLazySingleton<GetAllPeopleCubit>(
    () => GetAllPeopleCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  /// Add Update People Screen
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
    () =>
        ManageUsersCubit(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
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

  /// Manage Application Features/Screens
  appDatabase.registerTable(ApplicationTypeTable());

  getIt.registerLazySingleton<ApplicationTypesRepository>(
    () => ApplicationTypesRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<ApplicationLocalDataSource>(
    () => ApplicationLocalDataSource(appDatabase: getIt()),
  );

  getIt.registerLazySingleton(() => GetAllApplicationTypesUseCase(getIt()));

  getIt.registerLazySingleton(() => UpdateApplicationTypesUseCase(getIt()));

  getIt.registerLazySingleton(
    () => GetApplicationTypesInfoByIDUseCase(getIt()),
  );

  getIt.registerFactory<ApplicationTypesScreenCubit>(
    () => ApplicationTypesScreenCubit(getIt()),
  );

  getIt.registerFactory<UpdateApplicationTypesScreenCubit>(
    () => UpdateApplicationTypesScreenCubit(getIt(), getIt()),
  );

  /// Manage Test Types Features/Screens
  appDatabase.registerTable(TestTypeTable());

  getIt.registerLazySingleton<TestTypesRepository>(
    () => TestTypesRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<TestTypeLocalDataSource>(
    () => TestTypeLocalDataSource(appDatabase: getIt()),
  );

  getIt.registerLazySingleton(() => GetAllTestTypesUseCase(getIt()));

  getIt.registerLazySingleton(() => GetTestTypesInfoByIDUseCase(getIt()));

  getIt.registerLazySingleton(() => UpdateTestTypesUseCase(getIt()));

  getIt.registerFactory<TestTypesScreenCubit>(
    () => TestTypesScreenCubit(getIt()),
  );

  getIt.registerFactory<UpdateTestTypesScreenCubit>(
    () => UpdateTestTypesScreenCubit(getIt(), getIt()),
  );

  /// Init Database
  appDatabase.registerTable(LicenseClassTable());
  appDatabase.registerTable(ApplicationTable());
  appDatabase.registerTable(LocalDrivingLicenseApplicationTable());
  appDatabase.registerTable(TestAppointmentsTable());
  appDatabase.registerTable(TestTable());
  appDatabase.registerTable(LocalDrivingLicenseApplicationViewTable());
  //appDatabase.registerTable(DriversTable());

  /// Feature Applications/Application Core
  getIt.registerLazySingleton<ApplicationLocalDataSource>(
    () => ApplicationLocalDataSource(appDatabase: getIt()),
  );

  getIt.registerLazySingleton<ApplicationsRepository>(
    () => ApplicationsRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetAllApplicationsUseCase(getIt()));

  getIt.registerLazySingleton(() => GetApplicationInfoByIDUseCase(getIt()));

  getIt.registerLazySingleton(
    () => GetActiveApplicationIDForLicenseClassUseCase(getIt()),
  );

  getIt.registerLazySingleton(() => GetActiveApplicationIDUseCase(getIt()));

  getIt.registerLazySingleton(() => IsActiveApplicationUseCase(getIt()));

  getIt.registerLazySingleton(() => AddApplicationUseCase(getIt()));

  getIt.registerLazySingleton(() => UpdateApplicationUseCase(getIt()));

  getIt.registerLazySingleton(() => CancelApplicationUseCase(getIt()));

  getIt.registerLazySingleton(() => SetCompleteApplicationUseCase(getIt()));

  ///Feature Applications/Manage  Driving License Services /Local Screens
  getIt.registerLazySingleton<LocalDrivingLicenseApplicationRepository>(
    () => LocalDrivingLicenseApplicationRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<LocalDrivingLicenseApplicationLocalDataSource>(
    () => LocalDrivingLicenseApplicationLocalDataSource(getIt()),
  );

  getIt.registerLazySingleton(() => GetAllLicenseClassesUseCase(getIt()));

  getIt.registerLazySingleton(() => GetDataSharedPrefUseCase(getIt()));

  getIt.registerLazySingleton(
    () => GetActiveApplicationIDForLicenseClassUseCase(getIt()),
  );

  getIt.registerFactory<AddUpdateLocalDrLiApplicationScreenCubit>(
    () => AddUpdateLocalDrLiApplicationScreenCubit(getIt(), getIt(), getIt()),
  );
}
