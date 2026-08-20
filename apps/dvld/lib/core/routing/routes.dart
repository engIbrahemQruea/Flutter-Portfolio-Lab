abstract class DRoutes {
  static const String loginScreen = '/';
  static const String dashboard = '/dashboard';

  /// Applications Screen And Sub Screens
  static const String applications = '/applications';
  static const String applicationTypes = '$applications/applicationTypes';
  static const String updateApplicationTypes =
      '$applicationTypes/updateApplicationTypes';
  static const String testTypesScreen = '$applications/testTypes';
  static const String updateTestTypesScreen =
      '$testTypesScreen/updateTestTypes';
      static const String addUpdateLocalDrLiApplicationsScreen =
      '$applications/addUpdateLocalDrLiApplicationsScreen';

  /// People Screen And Sub Screens
  static const String peopleScreen = '/peopleScreen';
  static const String addUpdatePeopleScreen =
      '$peopleScreen/addUpdatePeopleScreen';
  static const String personDetailsScreen = '$peopleScreen/personDetailsScreen';

  /// Manage Users Screen And Sub Screens
  static const String manageUsersScreen = '/manageUsersScreen';
  static const String addUpdateUsersScreen =
      '$manageUsersScreen/addUpdateUsersScreen';
  static const String showDetailsUserScreen =
      '$manageUsersScreen/showDetailsUserScreen';
  static const String changePasswordUserScreen =
      '$manageUsersScreen/changePasswordUserScreen';

  /// Drivers Screen
  static const String drivers = '/drivers';
}
