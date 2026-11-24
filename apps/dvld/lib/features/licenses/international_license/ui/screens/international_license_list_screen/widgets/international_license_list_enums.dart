enum FilterInputType { none, text, booleanDropdown }

enum InternationalLicenseRowAction {
  personDetails,
  licenseDetails,
  licenseHistory,
}

enum InternationalLicenseListFilterColumn {
  none('None', null, FilterInputType.none),
  internationalId(
    'International ID',
    'internationalId',
    FilterInputType.text,
    isNumeric: true,
  ),
  applicationId(
    'Application ID',
    'applicationId',
    FilterInputType.text,
    isNumeric: true,
  ),
  driverId('Driver ID', 'driverId', FilterInputType.text, isNumeric: true),
  licenseId('License ID', 'licenseId', FilterInputType.text, isNumeric: true),
  // nationalNo('National No.', 'nationalNo', FilterInputType.text),
  // fullName('Full Name', 'fullName', FilterInputType.text),
  // releaseAppId(
  //   'Release App.ID',
  //   'releaseApplicationId',
  //   FilterInputType.text,
  //   isNumeric: true,
  // ),
  isActive('Is Active', 'isActive', FilterInputType.booleanDropdown);

  final String label;
  final String? fieldName;
  final FilterInputType inputType;
  final bool isNumeric;

  const InternationalLicenseListFilterColumn(
    this.label,
    this.fieldName,
    this.inputType, {
    this.isNumeric = false,
  });
}
