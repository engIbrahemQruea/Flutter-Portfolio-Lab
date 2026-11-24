enum DriverFilterColumn {
  none('None', null, isNumeric: false),
  driverId('Driver ID', 'driverId', isNumeric: true),
  personId('Person ID', 'personId', isNumeric: true),
  nationalNo('National No.', 'nationalNo', isNumeric: false),
  fullName('Full Name', 'fullName', isNumeric: false);

  final String label;

  final String? fieldName;
  final bool isNumeric;

  const DriverFilterColumn(
    this.label,
    this.fieldName, {
    required this.isNumeric,
  });
}
