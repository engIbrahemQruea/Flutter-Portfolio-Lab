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
  static const String showLocalDrLiApplicationsInfoScreen =
      '$applications/showLocalDrLiApplicationsInfoScreen';

/// Features Manage Applications / International License
        static const String newInternationalLicenseScreen =
      '$applications/newInternationalLicenseScreen';

  static const String internationalLicenseListScreen =
      '$applications/internationalLicenseListScreen';

  static const String showInternationalLicenseInfoScreen =
      '$applications/showInternationalLicenseInfoScreen';

  static const String takeTestScreen = '$applications/takeTestScreen';

  static const String listTestAppointmentsScreen =
      '$applications/listTestAppointmentsScreen';

  static const String scheduleTestWidgetScreen =
      '$applications/scheduleTestWidgetScreen';

  static const String listLocalDrLiApplicationsScreen =
      '$applications/listLocalDrLiApplicationsScreen';


  static const String issueFirstLicenseScreen =
      '$applications/issueFirstLicenseScreen';

  static const String showLicenseInfoScreen =
      '$applications/showLicenseInfoScreen';

  static const String showPersonLicenseHistoryScreen =
      '$applications/showPersonLicenseHistoryScreen';

  static const renewLicenseAppScreen = '$applications/renewLicenseAppScreen';

  static const replaceLicenseAppScreen =
      '$applications/replaceLicenseAppScreen';

  /// Features Manage Applications / Detained Licenses
  static const String detainLicenseScreen = '$applications/detainLicenseScreen';

  static const String listDetainedLicensesScreen =
      '$applications/listDetainedLicensesScreen';

  static const releaseDetainedLicenseScreen =
      '$applications/releaseDetainedLicenseScreen';

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
  static const String drivers = '/driversScreen';
}
