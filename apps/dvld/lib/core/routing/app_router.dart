import 'package:dvld/core/di/dependency_injection.dart';
import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/features/dashboard/presentation/views/dash_board_screen.dart';
import 'package:dvld/features/people/domain/usecases/get_list_people_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_first_name_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_id_use_case.dart';
import 'package:dvld/features/people/domain/usecases/get_people_by_national_no_use_case.dart';
import 'package:dvld/features/people/presentation/logic/cubit/get_all_people_cubit.dart';
import 'package:dvld/features/people/presentation/screens/people_screen.dart';
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
    initialLocation: DRoutes.dashboard,
    navigatorKey: _rootNavigatorKey,
    routes: [
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
                path: DRoutes.peopleScreen,
                name: DRoutes.peopleScreen,
                builder: (context, state) =>
                    const Center(child: Text('People Screen')),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorPeopleKey,
            routes: [
              GoRoute(
                path: DRoutes.applications,
                name: DRoutes.applications,
                builder: (context, state) => BlocProvider(
                  create: (context) => GetAllPeopleCubit(
                    getIt<GetListPeopleUseCase>(),
                    getIt<GetPeopleByIdUseCase>(),
                    getIt<GetPeopleByNationalNoUseCase>(),
                    getIt<GetPeopleByFirstNameUseCase>(),
                  ),
                  child: const PeopleScreen(),
                ),
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
                path: DRoutes.users,
                name: DRoutes.users,
                builder: (context, state) =>
                    const Center(child: Text('Users Screen')),
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
