import 'package:dvld/core/di/dependency_injection.dart';
import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/features/dashboard/presentation/views/dash_board_screen.dart';
import 'package:dvld/features/login/presentation/logic/login_screen_cubit/login_screen_cubit.dart';
import 'package:dvld/features/login/presentation/screens/login_screen.dart';
import 'package:dvld/features/manage_application/application_types/ui/logic/application_types_screen_cubit/application_types_screen_cubit.dart';
import 'package:dvld/features/manage_application/application_types/ui/logic/update_application_types_screen_cubit/update_application_types_screen_cubit.dart';
import 'package:dvld/features/manage_application/application_types/ui/screens/application_types_screen.dart';
import 'package:dvld/features/manage_application/application_types/ui/screens/update_application_types_screen/update_application_types_screen.dart';
import 'package:dvld/features/manage_application/test_types/ui/logic/index_test_type_cubit.dart';
import 'package:dvld/features/manage_application/test_types/ui/screens/index_test_types_screen.dart';
import 'package:dvld/features/manage_application/test_types/ui/screens/update_test_types_screen.dart';
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
                        create: (context) => AddUpdateFormCubit(
                          getIt(),
                          getIt(),
                          getIt(),
                          getIt(),
                          getIt(),
                        )..getAllCountries(),
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
                builder: (context, state) =>
                    const Center(child: Text('Drivers Screen')),
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
