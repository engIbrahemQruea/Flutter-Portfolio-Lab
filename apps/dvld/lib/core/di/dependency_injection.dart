import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/helpers/shared_pref_helper.dart';
import 'package:dvld/features/applications/application_types/data/data_sources/application_type_table.dart';
import 'package:dvld/features/applications/application_types/data/index_data_application_type.dart';
import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/applications/application_types/ui/logic/application_types_screen_cubit/application_types_screen_cubit.dart';
import 'package:dvld/features/applications/application_types/ui/logic/update_application_types_screen_cubit/update_application_types_screen_cubit.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_local_data_source.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/data/repositories_impl/applications_repository_impl.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';
import 'package:dvld/features/applications/applications_core/domain/use_cases/index_app_core_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/issue_first_license/issue_first_license_data_source.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/issue_first_license/issue_first_license_data_source_impl.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_local_data_source.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_view_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/repository_impl/issue_first_license_repository_impl.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/repository_impl/local_driving_license_application_repository_impl.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/issue_first_license_repository.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/index_local_license_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/issue_first_license/logic/issue_first_license_cubit/issue_first_license_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/logic/local_driving_license_applications_list_screen_cubit/local_driving_license_applications_list_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/driving_license_application_info/logic/driving_license_application_info_cubit/driving_license_application_info_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/data/data_sources/renew_license_data_sources.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/data/repository_impl/renew_license_repository_impl.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/repositories/renew_license_repository.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/use_case/init_renew_license_app_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/use_case/renew_license_app_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/ui/logic/renew_license_app_cubit/renew_license_app_cubit.dart';
import 'package:dvld/features/applications/release_detained_license/data/data_sources/release_detained_license_data_source.dart';
import 'package:dvld/features/applications/release_detained_license/data/repositories/release_detained_license_repository_impl.dart';
import 'package:dvld/features/applications/release_detained_license/domain/repositories/release_detained_license_repository.dart';
import 'package:dvld/features/applications/release_detained_license/domain/use_case/get_release_details_use_case.dart';
import 'package:dvld/features/applications/release_detained_license/domain/use_case/release_detained_license_use_case.dart';
import 'package:dvld/features/applications/release_detained_license/ui/logic/release_detained_license_cubit/release_detained_license_cubit.dart';
import 'package:dvld/features/applications/replace_license/data/data_sources/replace_license_data_source.dart';
import 'package:dvld/features/applications/replace_license/data/repository_impl/replace_license_repository_impl.dart';
import 'package:dvld/features/applications/replace_license/domain/repositories/replace_license_repository.dart';
import 'package:dvld/features/applications/replace_license/domain/use_cases/create_replace_license_use_case.dart';
import 'package:dvld/features/applications/replace_license/domain/use_cases/init_replace_license_use_case.dart';
import 'package:dvld/features/applications/replace_license/ui/logic/replace_license_screen_cubit/replace_license_cubit.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_item_table.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_local_data_source.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_local_data_source_impl.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart'
    show DriversTable;
import 'package:dvld/features/drivers/data/repository_impl/drivers_repository_impl.dart';
import 'package:dvld/features/drivers/domain/repositories/drivers_repository.dart';
import 'package:dvld/features/drivers/domain/use_cases/fetch_all_drivers_use_case.dart';
import 'package:dvld/features/drivers/domain/use_cases/fetch_driver_info_by_person_id_use_case.dart';
import 'package:dvld/features/drivers/ui/logic/drivers_screen_cubit/drivers_screen_cubit.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_local_data_sources.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_table.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_view_table.dart';
import 'package:dvld/features/licenses/detain_licenses/data/repository_impl/detain_license_repository_impl.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/repositories/detain_licenses_repository.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/use_cases/add_detain_license_use_case.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/use_cases/get_all_detain_licenses_use_case.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/use_cases/is_license_detained_use_case.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_list_screen/logic/detained_licenses_list_cubit/detained_licenses_list_cubit.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_screen/logic/detain_license_cubit/detain_license_cubit.dart';
import 'package:dvld/features/licenses/international_license/data/data_sources/international_licenses_local_data_sources.dart';
import 'package:dvld/features/licenses/international_license/data/data_sources/international_licenses_table.dart';
import 'package:dvld/features/licenses/international_license/data/repositories_impl/international_license_repository_impl.dart';
import 'package:dvld/features/licenses/international_license/domain/repositories/international_license_repository.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_active_international_license_id_by_driver_id_use_case.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_all_international_licenses_use_case.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_driver_international_licenses_use_case.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_init_details_new_international_license_use_case.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/get_international_license_details_by_international_id_use_case.dart';
import 'package:dvld/features/licenses/international_license/domain/usecases/issue_international_license_use_case.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/logic/international_license_list_cubit/international_license_list_cubit.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/new_international_license_screen/logic/new_international_license_cubit/new_international_license_cubit.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/show_international_license_info_screen/logic/cubit/show_international_license_info_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_local_data_source.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_local_data_source_impl.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/repository_impl/license_repository_impl.dart';
import 'package:dvld/features/licenses/licenses_core/domain/repositories/license_repository.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/fetch_license_details_info_by_id.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/fetch_license_id_by_local_app_id_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/fetch_license_info_by_license_id_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/get_both_info_licenses_local_and_international_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/get_driver_local_licenses_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/logic/driver_license_info_with_filter_cubit/driver_license_info_with_filter_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/license_history_widgets/ui/logic/driver_licenses_history_control_cubit/driver_licenses_history_control_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/license_history_screen/ui/logic/cubit/person_license_history_screen_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/show_license_info_screen/logic/show_license_info_cubit/show_license_info_cubit.dart';
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
import 'package:dvld/features/tests/schedule_test/domain/use_case/get_schedule_test_info_use_case.dart';
import 'package:dvld/features/tests/schedule_test/domain/use_case/save_schedule_test_info_use_case.dart';
import 'package:dvld/features/tests/schedule_test/ui/logic/schedule_test/schedule_test_cubit.dart';
import 'package:dvld/features/tests/take_test/domain/use_case/get_take_test_info_use_case.dart';
import 'package:dvld/features/tests/take_test/ui/logic/take_test_cubit/take_test_cubit.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointment_local_data_source.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointment_local_data_source_impl.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/tests/test_appointments/data/repositories_impl/test_appointments_repository_impl.dart';
import 'package:dvld/features/tests/test_appointments/domain/use_cases/create_schedule_and_retake_test_application_use_case.dart';
import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';
import 'package:dvld/features/tests/test_appointments/ui/logic/test_appointments_list/test_appointments_list_cubit.dart';
import 'package:dvld/features/tests/test_types/data/data_sources/test_type_table.dart';
import 'package:dvld/features/tests/test_types/data/index_data_test_type.dart';
import 'package:dvld/features/tests/test_types/ui/logic/index_test_type_cubit.dart';
import 'package:dvld/features/tests/tests_core/data/data_sources/test_table.dart';
import 'package:dvld/features/tests/tests_core/domain/use_cases/add_new_test_use_case.dart';
import 'package:dvld/features/tests/tests_core/domain/use_cases/get_last_test_by_person_id_and_test_type_id_and_license_class_id_use_case.dart';
import 'package:dvld/features/tests/tests_core/domain/use_cases/get_passed_test_count_use_case.dart';
import 'package:dvld/features/tests/tests_core/index_tests_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/tests/test_appointments/data/data_sources/test_appointments_view_table.dart';

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
  getIt.registerFactory<AddUpdateFormCubit>(
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

  /// Feature Applications/Application Core
  getIt.registerLazySingleton<ApplicationsRepository>(
    () => ApplicationsRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<ApplicationLocalDataSource>(
    () => ApplicationLocalDataSource(getIt()),
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

  getIt.registerLazySingleton(() => DeleteApplicationUseCase(getIt()));

  /// Features Applications/Application Types
  appDatabase.registerTable(ApplicationTypeTable());

  getIt.registerLazySingleton<ApplicationTypesRepository>(
    () => ApplicationTypesRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<ApplicationTypesLocalDataSource>(
    () => ApplicationTypesLocalDataSource(appDatabase: getIt()),
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
  appDatabase.registerTable(DriversTable());
  appDatabase.registerTable(LicenseTable());
  appDatabase.registerTable(DriversView());
  appDatabase.registerTable(InternationalLicensesTable());

  ///Feature Applications/Manage  Driving License Services /Local Screens
  getIt.registerLazySingleton<LocalDrivingLicenseApplicationRepository>(
    () => LocalDrivingLicenseApplicationRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<LocalDrivingLicenseApplicationLocalDataSource>(
    () => LocalDrivingLicenseApplicationLocalDataSource(getIt()),
  );

  getIt.registerLazySingleton(() => GetAllLicenseClassesUseCase(getIt()));

  getIt.registerLazySingleton(
    () => GetLicenseClassByLicenseClassIdUseCase(getIt()),
  );

  getIt.registerLazySingleton(() => GetDataSharedPrefUseCase(getIt()));

  getIt.registerLazySingleton(
    () => CreateLocalDrivingLicenseApplicationAndApplicationsUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => UpdateLocalDrivingLicenseApplicationAndApplicationsUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetLocalDrivingLicenseApplicationInfoByIdUseCase(
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  getIt.registerFactory<AddUpdateLocalDrLiApplicationScreenCubit>(
    () => AddUpdateLocalDrLiApplicationScreenCubit(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  /// Local Driving License Application List && Cubit
  getIt.registerLazySingleton(
    () => GetAllLocalDrivingLicenseApplicationUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetLocalApplicationMenuPermissionsUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => DeleteLocalDrivingLicenseApplicationUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => DeleteLocalDrLiAppAndApplicationUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => IsLicenseExistUseCase(getIt(), getIt(), getIt()),
  );

  getIt.registerFactory<LocalDrivingLicenseApplicationsListScreenCubit>(
    () => LocalDrivingLicenseApplicationsListScreenCubit(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  /// Local Driving License Application Info && Cubit / Issue Driving License
  getIt.registerLazySingleton<IssueFirstLicenseDataSource>(
    () => IssueFirstLicenseDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<IssueFirstLicenseRepository>(
    () => IssueFirstLicenseRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => IssueFirstLicenseUseCase(getIt()));

  getIt.registerLazySingleton(() => FetchLicenseIdByLocalAppIdUseCase(getIt()));

  getIt.registerLazySingleton(
    () => FetchLicenseDetailsInfoByIdUseCase(getIt(), getIt()),
  );

  getIt.registerFactory<IssueFirstLicenseCubit>(
    () => IssueFirstLicenseCubit(getIt(), getIt()),
  );

  /// Local Driving License Application Info && Cubit / Show Driving License Info
  getIt.registerFactory<ShowLicenseInfoCubit>(
    () => ShowLicenseInfoCubit(getIt(), getIt()),
  );

  getIt.registerFactory<DriverLicenseInfoWithFilterCubit>(
    () => DriverLicenseInfoWithFilterCubit(getIt()),
  );

  /// Local Driving License Application Info && Cubit / Renew Driving License

  getIt.registerLazySingleton(() => RenewLicenseDataSource(getIt()));

  getIt.registerLazySingleton<RenewLicenseRepository>(
    () => RenewLicenseRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => InitRenewLicenseAppUseCase(getIt(), getIt(), getIt(), getIt()),
  );

  getIt.registerLazySingleton(() => RenewLicenseAppUseCase(getIt()));

  getIt.registerFactory<RenewLicenseAppCubit>(
    () => RenewLicenseAppCubit(getIt(), getIt()),
  );

  /// Local Driving License Application Info && Cubit / Replace Driving License

  getIt.registerLazySingleton(() => ReplaceLicenseDataSource(getIt()));

  getIt.registerLazySingleton<ReplaceLicenseRepository>(
    () => ReplaceLicenseRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => InitReplaceLicenseUseCase(getIt(), getIt()),
  );

  getIt.registerLazySingleton(() => CreateReplaceLicenseUseCase(getIt()));

  getIt.registerFactory<ReplaceLicenseCubit>(
    () => ReplaceLicenseCubit(getIt(), getIt(), getIt()),
  );

  /// Local Driving License Application Info && Cubit / Reusable Widgets

  getIt.registerLazySingleton<GetDrivingLicenseApplicationInfoUseCase>(
    () => GetDrivingLicenseApplicationInfoUseCase(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  getIt.registerFactory<DrivingLicenseApplicationInfoCubit>(
    () => DrivingLicenseApplicationInfoCubit(getIt()),
  );

  /// Feature Tests/Test_core

  getIt.registerLazySingleton<TestLocalDataSource>(
    () => TestLocalDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<TestRepository>(
    () => TestRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetLastTestByPersonIDAndTestTypeIDAndLicenseClassIDUseCase(getIt()),
  );

  getIt.registerLazySingleton(() => AddNewTestUseCase(getIt()));

  getIt.registerLazySingleton(() => GetPassedTestCountUseCase(getIt()));

  /// Feature Tests/TestAppointments

  appDatabase.registerTable(TestAppointmentsTable());
  appDatabase.registerTable(TestAppointmentsViewTable());

  getIt.registerLazySingleton<TestAppointmentLocalDataSource>(
    () => TestAppointmentLocalDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<TestAppointmentsRepository>(
    () => TestAppointmentsRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetAllTestAppointmentsUseCase(getIt()));

  getIt.registerLazySingleton(() => GetTestAppointmentInfoByIdUseCase(getIt()));

  getIt.registerLazySingleton(
    () => GetApplicationTestAppointmentsPerTestTypeUseCase(getIt()),
  );

  getIt.registerLazySingleton(() => GetLastTestAppointmentUseCase(getIt()));

  getIt.registerLazySingleton(
    () => GetTestIdByTestAppointmentIdUseCase(getIt()),
  );

  getIt.registerLazySingleton(() => UpdateTestAppointmentUseCase(getIt()));

  getIt.registerLazySingleton(() => AddTestAppointmentUseCase(getIt()));

  getIt.registerLazySingleton(
    () => CanPrescheduleTestUseCase(getIt(), getIt(), getIt()),
  );

  getIt.registerLazySingleton(
    () => CreateScheduleAndRetakeTestApplicationUseCase(getIt()),
  );

  getIt.registerFactory<TestAppointmentsListCubit>(
    () => TestAppointmentsListCubit(getIt(), getIt(), getIt()),
  );

  // Feature Tests/ScheduleTest

  getIt.registerLazySingleton(
    () => GetScheduleTestInfoUseCase(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => SaveScheduleTestAppointmentUseCase(getIt(), getIt(), getIt()),
  );

  getIt.registerFactory<ScheduleTestCubit>(
    () => ScheduleTestCubit(getIt(), getIt()),
  );

  // Feature Tests/TakeTest

  getIt.registerLazySingleton(
    () => GetTakeTestInfoUseCase(getIt(), getIt(), getIt()),
  );

  getIt.registerFactory<TakeTestCubit>(
    () => TakeTestCubit(getIt(), getIt(), getIt()),
  );

  /// Feature Drivers

  getIt.registerLazySingleton<DriversLocalDataSource>(
    () => DriversLocalDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<DriversRepository>(
    () => DriversRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<FetchAllDriversUseCase>(
    () => FetchAllDriversUseCase(getIt()),
  );

  getIt.registerLazySingleton<FetchDriverInfoByPersonIdUseCase>(
    () => FetchDriverInfoByPersonIdUseCase(getIt()),
  );

  getIt.registerLazySingleton<FetchLicenseInfoByLicenseIdUseCase>(
    () => FetchLicenseInfoByLicenseIdUseCase(getIt()),
  );

  getIt.registerFactory<DriversScreenCubit>(() => DriversScreenCubit(getIt()));

  /// Licenses Features
  getIt.registerLazySingleton<LicenseLocalDataSource>(
    () => LicenseLocalDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<LicenseRepository>(
    () => LicenseRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetBothInfoLicensesLocalAndInternationalUseCase(getIt(), getIt()),
  );

  getIt.registerLazySingleton(
    () => GetDriverLocalLicensesUseCase(getIt(), getIt()),
  );

  /// Feature Licenses/ Driver Licenses History Control Cubit
  getIt.registerFactory<DriverLicensesHistoryControlCubit>(
    () => DriverLicensesHistoryControlCubit(getIt(), getIt()),
  );

  /// Feature Licenses/ Show Person License History Cubit
  getIt.registerFactory<PersonLicenseHistoryScreenCubit>(
    () => PersonLicenseHistoryScreenCubit(),
  );

  /// Feature Licenses/ International Licenses

  getIt.registerLazySingleton<InternationalLicensesLocalDataSource>(
    () => InternationalLicensesLocalDataSource(getIt()),
  );

  getIt.registerLazySingleton<InternationalLicenseRepository>(
    () => InternationalLicenseRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetDriverInternationalLicensesUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetActiveInternationalLicenseIdByDriverIdUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetInitDetailsNewInternationalLicenseUseCase(getIt(), getIt()),
  );

  /// Feature Licenses/ Detain License
  appDatabase.registerTable(DetainedLicensesTable());
  appDatabase.registerTable(DetainedLicensesView());

  getIt.registerLazySingleton(() => DetainLicensesLocalDataSource(getIt()));

  getIt.registerLazySingleton<DetainLicensesRepository>(
    () => DetainLicenseRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => IsLicenseDetainedUseCase(getIt()));

  getIt.registerLazySingleton(() => GetAllDetainLicensesUseCase(getIt()));

  getIt.registerLazySingleton(() => AddDetainLicenseUseCase(getIt()));

  getIt.registerFactory<DetainLicenseCubit>(
    () => DetainLicenseCubit(getIt(), getIt(), getIt()),
  ); //()

  /// Feature Licenses/ Release License

  getIt.registerLazySingleton(() => ReleaseDetainedLicenseDataSource(getIt()));

  getIt.registerLazySingleton<ReleaseDetainedLicenseRepository>(
    () => ReleaseDetainedLicenseRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetReleaseDetailsUseCase(getIt(), getIt(), getIt(), getIt()),
  );

  getIt.registerLazySingleton(() => ReleaseDetainedLicenseUseCase(getIt()));

  getIt.registerFactory<ReleaseDetainedLicenseCubit>(
    () => ReleaseDetainedLicenseCubit(getIt(), getIt(), getIt()),
  );

  /// Feature Licenses/Detain License List Screen

  getIt.registerFactory<DetainedLicensesListCubit>(
    () => DetainedLicensesListCubit(getIt()),
  );

  /// Feature Licenses/ New International License

  getIt.registerLazySingleton(() => IssueInternationalLicenseUseCase(getIt()));

  getIt.registerFactory<NewInternationalLicenseCubit>(
    () => NewInternationalLicenseCubit(getIt(), getIt(), getIt(), getIt()),
  );

  /// Feature Licenses/ show International License Info

  getIt.registerLazySingleton(
    () => GetInternationalLicenseDetailsByInternationalIdUseCase(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerFactory<ShowInternationalLicenseInfoCubit>(
    () => ShowInternationalLicenseInfoCubit(getIt()),
  );

  /// Feature Licenses/  International License List Screen

  getIt.registerLazySingleton(
    () => GetAllInternationalLicensesUseCase(getIt()),
  );

  getIt.registerFactory<InternationalLicenseListCubit>(
    () => InternationalLicenseListCubit(getIt()),
  );
}
