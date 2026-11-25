import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_table.dart';

class DetainLicensesQuery {
  static const String isLicenseDetainedQuery = '''
    SELECT 1 AS IsDetained
    FROM ${DetainedLicensesTable.tableName}
    WHERE ${DetainedLicensesTable.colLicenseID} = ? 
      AND ${DetainedLicensesTable.colIsReleased} = 0
    LIMIT 1;
  ''';

  static const String releaseDetainLicenseQuery =
      '''
    UPDATE ${DetainedLicensesTable.tableName} 
    SET ${DetainedLicensesTable.colIsReleased} = 1,
        ${DetainedLicensesTable.colReleaseDate} = ?,
        ${DetainedLicensesTable.colReleasedByUserID} = ?,
        ${DetainedLicensesTable.colReleaseApplicationID} = ?
    WHERE ${DetainedLicensesTable.colDetainID} = ?
  ''';
}
