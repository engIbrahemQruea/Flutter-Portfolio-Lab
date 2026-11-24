enum LocalApplicationMenuAction {
  showAppDetails('Show Application Details'),
  editApp('Edit Application'),
  deleteApp('Delete Application'),
  cancelApp('Cancel Application'),
  scheduleTests('Schedule Tests'),
  scheduleVisionTest('Schedule Vision Test'),
  scheduleWriteTest('Schedule Write Test'),
  scheduleStreetTest('Schedule Street Test'),
  issueDLFirstTime('Issue Driving License (First Time)'),
  showLicense('Show License'),
  showPersonLicenseHistory('Show Person License History');

  final String label;

  const LocalApplicationMenuAction(this.label);
}
