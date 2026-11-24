import 'package:dvld/core/di/dependency_injection.dart';
import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/features/applications/application_types/ui/logic/application_types_screen_cubit/application_types_screen_cubit.dart';
import 'package:dvld/features/applications/application_types/ui/logic/update_application_types_screen_cubit/update_application_types_screen_cubit.dart';
import 'package:dvld/features/applications/application_types/ui/screens/application_types_screen.dart';
import 'package:dvld/features/applications/application_types/ui/screens/update_application_types_screen/update_application_types_screen.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/issue_first_license/logic/issue_first_license_cubit/issue_first_license_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/issue_first_license/screen/issue_first_license_screen.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/add_update_local_driving_license_application_screen.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/list_local_driving_license_applications_screen.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/logic/local_driving_license_applications_list_screen_cubit/local_driving_license_applications_list_screen_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/show_local_driving_license_application_info/show_local_driving_license_application_info_screen.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/driving_license_application_info/logic/driving_license_application_info_cubit/driving_license_application_info_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/ui/logic/renew_license_app_cubit/renew_license_app_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/ui/renew_license_app_screen.dart';
import 'package:dvld/features/applications/release_detained_license/ui/logic/release_detained_license_cubit/release_detained_license_cubit.dart';
import 'package:dvld/features/applications/release_detained_license/ui/screen/release_detained_license_screen.dart';
import 'package:dvld/features/applications/replace_license/ui/logic/replace_license_screen_cubit/replace_license_cubit.dart';
import 'package:dvld/features/applications/replace_license/ui/screen/replace_license_screen.dart';
import 'package:dvld/features/dashboard/presentation/views/dash_board_screen.dart';
import 'package:dvld/features/drivers/ui/logic/drivers_screen_cubit/drivers_screen_cubit.dart';
import 'package:dvld/features/drivers/ui/screen/drivers_screen.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_list_screen/detain_license_list_screen.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_list_screen/logic/detained_licenses_list_cubit/detained_licenses_list_cubit.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_screen/detain_license_screen.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_screen/logic/detain_license_cubit/detain_license_cubit.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/international_license_list_screen.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/logic/international_license_list_cubit/international_license_list_cubit.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/new_international_license_screen/logic/new_international_license_cubit/new_international_license_cubit.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/new_international_license_screen/new_international_license_screen.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/show_international_license_info_screen/logic/cubit/show_international_license_info_cubit.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/show_international_license_info_screen/show_international_license_info_screen.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info_with_filter/logic/driver_license_info_with_filter_cubit/driver_license_info_with_filter_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/license_history_widgets/ui/logic/driver_licenses_history_control_cubit/driver_licenses_history_control_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/license_history_screen/ui/logic/cubit/person_license_history_screen_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/license_history_screen/ui/screens/person_license_history_screen.dart';
import 'package:dvld/features/licenses/licenses_core/ui/show_license_info_screen/logic/show_license_info_cubit/show_license_info_cubit.dart';
import 'package:dvld/features/licenses/licenses_core/ui/show_license_info_screen/show_license_info_screen.dart';
import 'package:dvld/features/login/presentation/logic/login_screen_cubit/login_screen_cubit.dart';
import 'package:dvld/features/login/presentation/screens/login_screen.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:dvld/features/manage_users/presentation/logic/change_password_user_screen_cubit/cubit/change_password_user_cubit.dart';
import 'package:dvld/features/manage_users/presentation/logic/cubit/manage_users_cubit.dart';
import 'package:dvld/features/manage_users/presentation/logic/user_information_card_cubit/user_information_card_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/add_update_users_screen.dart';
import 'package:dvld/features/manage_users/presentation/screens/change_password_user_screen/change_password_user_screen.dart';
import 'package:dvld/features/manage_users/presentation/screens/manage_users_screen.dart';
import 'package:dvld/features/manage_users/presentation/screens/show_details_user_screen/show_details_user_screen.dart';
import 'package:dvld/features/people/domain/usecases/get_list_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_first_name_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_national_no_use_case.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/cubit/get_all_people_cubit.dart';
import 'package:dvld/features/people/presentation/person_details_screen/logic/person_details_cubit/person_details_cubit.dart';
import 'package:dvld/features/people/presentation/person_details_screen/person_details_screen.dart';
import 'package:dvld/features/people/presentation/screens/people_screen.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/add_update_people_screen.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_selector/cubit/person_selector_cubit.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_type.dart';
import 'package:dvld/features/tests/schedule_test/ui/logic/schedule_test/schedule_test_cubit.dart';
import 'package:dvld/features/tests/schedule_test/ui/screens/schedule_test_widget_screen.dart';
import 'package:dvld/features/tests/take_test/ui/logic/take_test_cubit/take_test_cubit.dart';
import 'package:dvld/features/tests/take_test/ui/screens/take_test_screen.dart';
import 'package:dvld/features/tests/test_appointments/ui/logic/test_appointments_list/test_appointments_list_cubit.dart';
import 'package:dvld/features/tests/test_appointments/ui/screens/test_appointments_list_screen.dart';
import 'package:dvld/features/tests/test_types/ui/logic/index_test_type_cubit.dart';
import 'package:dvld/features/tests/test_types/ui/screens/index_test_types_screen.dart';
import 'package:dvld/features/tests/test_types/ui/screens/update_test_types_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorDashboardKey = GlobalKey<NavigatorState>(
  debugLabel: 'dashboardShell',
);
final _shellNavigatorApplicationsKey = GlobalKey<NavigatorState>(
  debugLabel: 'applicationsShell',
);
final _shellNavigatorPeopleKey = GlobalKey<NavigatorState>(
  debugLabel: 'peopleShell',
);
final _shellNavigatorDriversKey = GlobalKey<NavigatorState>(
  debugLabel: 'driversShell',
);
final _shellNavigatorUsersKey = GlobalKey<NavigatorState>(
  debugLabel: 'usersShell',
);

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: DRoutes.loginScreen,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: DRoutes.loginScreen,
        name: DRoutes.loginScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginScreenCubit>(),
          child: const LoginScreen(),
        ),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DashboardScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDashboardKey,
            routes: [
              GoRoute(
                path: DRoutes.dashboard,
                name: DRoutes.dashboard,
                builder: (context, state) =>
                    const Center(child: Text('Dashboard Screen')),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorApplicationsKey,
            routes: [
              GoRoute(
                path: DRoutes.applications,
                name: DRoutes.applications,
                builder: (context, state) =>
                    const Center(child: Text('Applications Screen')),

                routes: [
                  GoRoute(
                    path: DRoutes.applicationTypes,
                    name: DRoutes.applicationTypes,
                    builder: (context, state) => BlocProvider(
                      create: (context) =>
                          getIt<ApplicationTypesScreenCubit>()
                            ..getAllApplicationTypes(),
                      child: const ApplicationTypesScreen(),
                    ),

                    routes: [
                      /// Feature Applications/Driving License Services/New Driving License/Local Driving License List Local Driving License Applications
                      GoRoute(
                        path: DRoutes.listLocalDrLiApplicationsScreen,
                        name: DRoutes.listLocalDrLiApplicationsScreen,
                        builder: (context, state) {
                          return BlocProvider(
                            create: (context) =>
                                getIt<
                                    LocalDrivingLicenseApplicationsListScreenCubit
                                  >()
                                  ..getAllLocalDrivingLicenseApplications(),
                            child:
                                const ListLocalDrivingLicenseApplicationsScreen(),
                          );
                        },
                      ),

                      /// Feature Applications/Driving License Services/New Driving License/Local Driving License Show Local Driving License Application
                      GoRoute(
                        path: DRoutes.showLocalDrLiApplicationsInfoScreen,
                        name: DRoutes.showLocalDrLiApplicationsInfoScreen,
                        builder: (context, state) {
                          final localDrLiApplicationIdString = state
                              .uri
                              .queryParameters['localDrLiApplicationId'];
                          final localDrLiApplicationIdInt =
                              localDrLiApplicationIdString == null
                              ? null
                              : int.parse(localDrLiApplicationIdString);

                          return BlocProvider(
                            create: (context) =>
                                getIt<DrivingLicenseApplicationInfoCubit>()
                                  ..loadApplicationInfoByLocalDrivingLicenseAppID(
                                    localDriLiceApplicationId:
                                        localDrLiApplicationIdInt,
                                  ),
                            child:
                                const ShowLocalDrivingLicenseApplicationInfoScreen(),
                          );
                        },
                      ),

                      /// Feature Applications/Detained Licenses
                      GoRoute(
                        path: DRoutes.detainLicenseScreen,
                        name: DRoutes.detainLicenseScreen,
                        builder: (context, state) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) =>
                                  getIt<DriverLicenseInfoWithFilterCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  getIt<DetainLicenseCubit>()..initialize(),
                            ),
                          ],
                          child: const DetainLicenseScreen(),
                        ),
                      ),

                      /// Feature Applications/ Release Detained Licenses
                      GoRoute(
                        path: DRoutes.releaseDetainedLicenseScreen,
                        name: DRoutes.releaseDetainedLicenseScreen,
                        builder: (context, state) {
                          final licenseIdString =
                              state.uri.queryParameters['licenseId'];
                          final licenseId = licenseIdString == null
                              ? null
                              : int.parse(licenseIdString);
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    getIt<DriverLicenseInfoWithFilterCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<ReleaseDetainedLicenseCubit>()
                                      ..getReleaseDetails(licenseId ?? 0),
                              ),
                            ],
                            child: ReleaseDetainedLicenseScreen(
                              licenseId: licenseId,
                            ),
                          );
                        },
                      ),

                      GoRoute(
                        path: DRoutes.listDetainedLicensesScreen,
                        name: DRoutes.listDetainedLicensesScreen,
                        builder: (context, state) => BlocProvider(
                          create: (context) =>
                              getIt<DetainedLicensesListCubit>()
                                ..getAllDetainLicenses(),
                          child: const DetainLicenseListScreen(),
                        ),
                      ),

                      ///Feature Applications/Driving License Services/New Driving License/Local Driving License Add Update Local Driving License Application
                      GoRoute(
                        path: DRoutes.addUpdateLocalDrLiApplicationsScreen,
                        name: DRoutes.addUpdateLocalDrLiApplicationsScreen,
                        builder: (context, state) {
                          final localDrLiApplicationIdString = state
                              .uri
                              .queryParameters['localDrLiApplicationId'];
                          final localDrLiApplicationIdInt =
                              localDrLiApplicationIdString == null
                              ? null
                              : int.parse(localDrLiApplicationIdString);

                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    getIt<PersonSelectorCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<
                                        AddUpdateLocalDrLiApplicationScreenCubit
                                      >()
                                      ..initAddUpdateLocalDrLiApplicationScreen(
                                        localDrLiApplicationID:
                                            localDrLiApplicationIdInt,
                                      ),
                              ),
                            ],
                            child:
                                const AddUpdateLocalDrivingLicenseApplicationScreen(),
                          );
                        },
                      ),

                      /// Feature Applications/Driving License Services/New Driving License/International Driving License
                      GoRoute(
                        path: DRoutes.newInternationalLicenseScreen,
                        name: DRoutes.newInternationalLicenseScreen,
                        builder: (context, state) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) =>
                                  getIt<DriverLicenseInfoWithFilterCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  getIt<NewInternationalLicenseCubit>()
                                    ..getInitDetails(),
                            ),
                          ],
                          child: const NewInternationalLicenseScreen(),
                        ),
                      ),

                      GoRoute(
                        path: DRoutes.showInternationalLicenseInfoScreen,
                        name: DRoutes.showInternationalLicenseInfoScreen,
                        builder: (context, state) {
                          final internationalIdString =
                              state.uri.queryParameters['internationalId'];
                          final internationalIdInt =
                              internationalIdString == null
                              ? null
                              : int.parse(internationalIdString);
                          return BlocProvider(
                            create: (context) =>
                                getIt<ShowInternationalLicenseInfoCubit>()
                                  ..getInternationalLicenseDetailsByInternationalId(
                                    internationalLicenseId:
                                        internationalIdInt ?? 0,
                                  ),
                            child: const ShowInternationalLicenseInfoScreen(),
                          );
                        },
                      ),

                      GoRoute(
                        path: DRoutes.internationalLicenseListScreen,
                        name: DRoutes.internationalLicenseListScreen,
                        builder: (context, state) => BlocProvider(
                          create: (context) =>
                              getIt<InternationalLicenseListCubit>()
                                ..getAllInternationalLicenses(),
                          child: const InternationalLicenseListScreen(),
                        ),
                      ),

                      GoRoute(
                        path: DRoutes.updateApplicationTypes,
                        name: DRoutes.updateApplicationTypes,
                        builder: (context, state) {
                          final appTypeIdString =
                              state.uri.queryParameters['appTypeId'];
                          final appTypeIdInt = appTypeIdString == null
                              ? null
                              : int.parse(appTypeIdString);
                          return BlocProvider(
                            create: (context) =>
                                getIt<UpdateApplicationTypesScreenCubit>()
                                  ..loadApplicationTypeById(
                                    applicationType: appTypeIdInt,
                                  ),
                            child: const UpdateApplicationTypesScreen(),
                          );
                        },
                      ),

                      /// Feature Tests/Test Appointments List Test Appointments
                      GoRoute(
                        path: DRoutes.listTestAppointmentsScreen,
                        name: DRoutes.listTestAppointmentsScreen,
                        builder: (context, state) {
                          final localDrLiApplicationIdString = state
                              .uri
                              .queryParameters['localDrLiApplicationId'];
                          final localDrLiApplicationIdInt =
                              localDrLiApplicationIdString == null
                              ? null
                              : int.parse(localDrLiApplicationIdString);
                          final testType = state.extra as ScheduleTestType;

                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    getIt<DrivingLicenseApplicationInfoCubit>()
                                      ..loadApplicationInfoByLocalDrivingLicenseAppID(
                                        localDriLiceApplicationId:
                                            localDrLiApplicationIdInt,
                                      ),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<TestAppointmentsListCubit>()
                                      ..getTestAppointmentsPerTestType(
                                        localDLapplicationID:
                                            localDrLiApplicationIdInt!,
                                        testTypeID: testType.value,
                                      ),
                              ),
                            ],
                            child: TestAppointmentsListScreen(
                              testType: testType,
                            ),
                          );
                        },
                      ),

                      // goRoute for menu screen
                      GoRoute(
                        path: DRoutes.issueFirstLicenseScreen,
                        name: DRoutes.issueFirstLicenseScreen,

                        builder: (context, state) {
                          final localDrLiApplicationIdString = state
                              .uri
                              .queryParameters['localDrLiApplicationId'];
                          final localDrLiApplicationIdInt =
                              localDrLiApplicationIdString == null
                              ? null
                              : int.parse(localDrLiApplicationIdString);
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    getIt<DrivingLicenseApplicationInfoCubit>()
                                      ..loadApplicationInfoByLocalDrivingLicenseAppID(
                                        localDriLiceApplicationId:
                                            localDrLiApplicationIdInt,
                                      ),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<IssueFirstLicenseCubit>()
                                      ..setLocalDLAppId(
                                        localDLApplicationId:
                                            localDrLiApplicationIdInt!,
                                      ),
                              ),
                            ],
                            child: const IssueFirstLicenseScreen(),
                          );
                        },
                      ),

                      GoRoute(
                        path: DRoutes.showLicenseInfoScreen,
                        name: DRoutes.showLicenseInfoScreen,
                        builder: (context, state) {
                          final localDrLiApplicationIdString = state
                              .uri
                              .queryParameters['localDrLiApplicationId'];
                          final localDrLiApplicationIdInt =
                              localDrLiApplicationIdString == null
                              ? null
                              : int.parse(localDrLiApplicationIdString);

                          final licenseIdString =
                              state.uri.queryParameters['licenseId'];
                          final licenseIdInt = licenseIdString == null
                              ? null
                              : int.parse(licenseIdString);
                          return BlocProvider(
                            create: (context) =>
                                getIt<ShowLicenseInfoCubit>()
                                  ..fetchLicenseDetailsInfoById(
                                    localDLAppId: localDrLiApplicationIdInt!,
                                    licenseId: licenseIdInt!,
                                  ),
                            child: const ShowLicenseInfoScreen(),
                          );
                        },
                      ),

                      GoRoute(
                        path: DRoutes.showPersonLicenseHistoryScreen,
                        name: DRoutes.showPersonLicenseHistoryScreen,
                        builder: (context, state) {
                          final personIdString =
                              state.uri.queryParameters['personId'];
                          final personIdInt = personIdString == null
                              ? null
                              : int.parse(personIdString);
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    getIt<PersonSelectorCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<DriverLicensesHistoryControlCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<PersonLicenseHistoryScreenCubit>(),
                              ),
                            ],
                            child: PersonLicenseHistoryScreen(
                              personId: personIdInt,
                            ),
                          );
                        },
                      ),

                      GoRoute(
                        path: DRoutes.renewLicenseAppScreen,
                        name: DRoutes.renewLicenseAppScreen,
                        builder: (context, state) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    getIt<DriverLicenseInfoWithFilterCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<RenewLicenseAppCubit>(),
                              ),
                            ],
                            child: const RenewLicenseAppScreen(),
                          );
                        },
                      ),

                      GoRoute(
                        path: DRoutes.replaceLicenseAppScreen,
                        name: DRoutes.replaceLicenseAppScreen,
                        builder: (context, state) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    getIt<DriverLicenseInfoWithFilterCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<ReplaceLicenseCubit>(),
                              ),
                            ],
                            child: const ReplaceLicenseScreen(),
                          );
                        },
                      ),

                      GoRoute(
                        path: DRoutes.scheduleTestWidgetScreen,
                        name: DRoutes.scheduleTestWidgetScreen,
                        builder: (context, state) {
                          final localDrLiApplicationIdString = state
                              .uri
                              .queryParameters['localDrLiApplicationId'];
                          final localDrLiApplicationIdInt =
                              localDrLiApplicationIdString == null
                              ? null
                              : int.parse(localDrLiApplicationIdString);
                          final testType = state.extra as ScheduleTestType;
                          final testAppointmentIdString =
                              state.uri.queryParameters['testAppointmentId'];
                          final testAppointmentIdInt =
                              testAppointmentIdString == null
                              ? null
                              : int.parse(testAppointmentIdString);
                          return BlocProvider(
                            create: (context) =>
                                getIt<ScheduleTestCubit>()..loadData(
                                  localAppId: localDrLiApplicationIdInt!,
                                  testType: testType,
                                  appointmentId: testAppointmentIdInt,
                                ),
                            child: const ScheduleTestWidgetScreen(),
                          );
                        },
                      ),

                      GoRoute(
                        path: DRoutes.takeTestScreen,
                        name: DRoutes.takeTestScreen,
                        builder: (context, state) {
                          final testAppointmentIdString =
                              state.uri.queryParameters['testAppointmentId'];
                          final testAppointmentIdInt =
                              testAppointmentIdString == null
                              ? null
                              : int.parse(testAppointmentIdString);

                          return BlocProvider(
                            create: (context) => getIt<TakeTestCubit>()
                              ..loadTakeTestData(
                                testAppointmentID: testAppointmentIdInt!,
                              ),
                            child: const TakeTestScreen(),
                          );
                        },
                      ),
                    ],
                  ),

                  GoRoute(
                    path: DRoutes.testTypesScreen,
                    name: DRoutes.testTypesScreen,
                    builder: (context, state) => BlocProvider(
                      create: (context) =>
                          getIt<TestTypesScreenCubit>()..getAllTestTypes(),
                      child: const TestTypesScreen(),
                    ),
                  ),

                  GoRoute(
                    path: DRoutes.updateTestTypesScreen,
                    name: DRoutes.updateTestTypesScreen,
                    builder: (context, state) {
                      final testTypeIdString =
                          state.uri.queryParameters['testTypeId'];
                      final testTypeIdInt = testTypeIdString == null
                          ? null
                          : int.parse(testTypeIdString);
                      return BlocProvider(
                        create: (context) =>
                            getIt<UpdateTestTypesScreenCubit>()
                              ..loadTestTypeInfoById(testTypeId: testTypeIdInt),
                        child: const UpdateTestTypesScreen(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorPeopleKey,
            routes: [
              GoRoute(
                path: DRoutes.peopleScreen,
                name: DRoutes.peopleScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) => GetAllPeopleCubit(
                    getIt<GetListPeopleUseCase>(),
                    getIt<GetPeopleByIdUseCase>(),
                    getIt<GetPeopleByNationalNoUseCase>(),
                    getIt<GetPeopleByFirstNameUseCase>(),
                    getIt(),
                  ),
                  child: const PeopleScreen(),
                ),
                routes: [
                  GoRoute(
                    path: DRoutes.addUpdatePeopleScreen,
                    name: DRoutes.addUpdatePeopleScreen,
                    builder: (context, state) {
                      final personIdString =
                          state.uri.queryParameters['personId'];
                      final personIdInt = personIdString == null
                          ? null
                          : int.parse(personIdString);
                      return BlocProvider(
                        create: (context) =>
                            getIt<AddUpdateFormCubit>()..getAllCountries(),
                        child: AddUpdatePeopleScreen(personId: personIdInt),
                      );
                    },
                  ),
                  GoRoute(
                    path: DRoutes.personDetailsScreen,
                    name: DRoutes.personDetailsScreen,
                    builder: (context, state) {
                      final personIdString =
                          state.uri.queryParameters['personId'];
                      final personIdInt = int.parse(personIdString!);
                      return BlocProvider(
                        create: (context) =>
                            getIt<PersonDetailsCubit>()
                              ..getInfoPersonDetailsById(personID: personIdInt),
                        child: PersonDetailsScreen(personId: personIdInt),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDriversKey,
            routes: [
              GoRoute(
                path: DRoutes.drivers,
                name: DRoutes.drivers,
                builder: (context, state) => Center(
                  child: BlocProvider(
                    create: (context) =>
                        getIt<DriversScreenCubit>()..fetchAllDrivers(),
                    child: DriversScreen(),
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorUsersKey,
            routes: [
              GoRoute(
                path: DRoutes.manageUsersScreen,
                name: DRoutes.manageUsersScreen,
                builder: (context, state) => BlocProvider(
                  create: (context) => getIt<ManageUsersCubit>()..getAllUsers(),
                  child: const ManageUsersScreen(),
                ),
                routes: [
                  GoRoute(
                    path: DRoutes.addUpdateUsersScreen,
                    name: DRoutes.addUpdateUsersScreen,
                    builder: (context, state) {
                      final userIdString = state.uri.queryParameters['userId'];
                      final userIdInt = userIdString == null
                          ? null
                          : int.parse(userIdString);
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                getIt<AddUpdateUserFormCubit>()
                                  ..onInit(userId: userIdInt),
                          ),
                          BlocProvider(
                            create: (context) => getIt<PersonSelectorCubit>(),
                          ),
                        ],
                        child: AddUpdateUsersScreen(),
                      );
                    },
                  ),

                  GoRoute(
                    path: DRoutes.showDetailsUserScreen,
                    name: DRoutes.showDetailsUserScreen,
                    builder: (context, state) {
                      final userIdString = state.uri.queryParameters['userId'];
                      final userIdInt = userIdString == null
                          ? null
                          : int.parse(userIdString);
                      return BlocProvider(
                        create: (context) =>
                            getIt<UserInformationCardCubit>()
                              ..getUserDetails(userId: userIdInt),
                        child: ShowDetailsUserScreen(),
                      );
                    },
                  ),

                  GoRoute(
                    path: DRoutes.changePasswordUserScreen,
                    name: DRoutes.changePasswordUserScreen,
                    builder: (context, state) {
                      final userIdString = state.uri.queryParameters['userId'];
                      final userIdInt = userIdString == null
                          ? null
                          : int.parse(userIdString);
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                getIt<UserInformationCardCubit>()
                                  ..getUserDetails(userId: userIdInt),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<ChangePasswordUserCubit>(),
                          ),
                        ],
                        child: ChangePasswordUserScreen(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // GoRoute(
      //   path: DRoutes.dashboard,
      //   name: DRoutes.dashboard,
      //   builder: (context, state) => const DashboardScreen(),
      // ),
    ],
  );
}
