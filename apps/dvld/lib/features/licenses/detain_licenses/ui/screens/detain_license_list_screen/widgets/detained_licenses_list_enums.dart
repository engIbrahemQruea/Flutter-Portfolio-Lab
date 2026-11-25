enum FilterInputType { none, text, booleanDropdown }

enum DetainedRowAction { personDetails, licenseDetails, licenseHistory, release }

enum DetainedListFilterColumn {
  none('None', null, FilterInputType.none),
  detainId('Detain ID', 'detainId', FilterInputType.text, isNumeric: true),
  nationalNo('National No.', 'nationalNo', FilterInputType.text),
  fullName('Full Name', 'fullName', FilterInputType.text),
  releaseAppId(
    'Release App.ID',
    'releaseApplicationId',
    FilterInputType.text,
    isNumeric: true,
  ),
  isReleased('Is Released', 'isReleased', FilterInputType.booleanDropdown);

  final String label;
  final String? fieldName;
  final FilterInputType inputType;
  final bool isNumeric;

  const DetainedListFilterColumn(
    this.label,
    this.fieldName,
    this.inputType, {
    this.isNumeric = false,
  });
}
