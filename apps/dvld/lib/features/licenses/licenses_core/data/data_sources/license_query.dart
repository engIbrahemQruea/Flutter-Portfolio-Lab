import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/people_table.dart';

class LicenseQuery {
  static const isActiveLicenseIDByPersonIdQuery =
      '''
    SELECT ${LicenseTable.colId} 
    FROM ${LicenseTable.tableName} l
    INNER JOIN ${DriversTable.tableName} d
    ON l.${LicenseTable.colDriverId} = d.${DriversTable.colDriverID}
    WHERE l.${LicenseTable.colLicenseClass} = ? 
    AND d.${DriversTable.colPersonID} = ?
    AND l.${LicenseTable.colIsActive} = 1
  ''';

  static const isActiveLicenseIDByDriverIdQuery =
      '''
    SELECT l.${LicenseTable.colId},l.${LicenseTable.colApplicationId},l.${LicenseTable.colLicenseClass} ,l.${LicenseTable.colIssueDate},l.${LicenseTable.colExpirationDate},l.${LicenseTable.colIsActive} 
    FROM ${LicenseTable.tableName} l
    INNER JOIN ${LicenseClassTable.tableName} lc ON l.${LicenseTable.colLicenseClass} = lc.${LicenseClassTable.colId}
    WHERE l.${LicenseTable.colDriverId} = ?
    ORDER BY l.${LicenseTable.colIsActive} DESC, l.${LicenseTable.colExpirationDate} DESC
  ''';

  static const getActiveLicenseIDByDriverIdQuery =
      '''
    SELECT l.*, lc.${LicenseClassTable.colName} 
    FROM ${LicenseTable.tableName} l
    INNER JOIN ${LicenseClassTable.tableName} lc ON l.${LicenseTable.colLicenseClass} = lc.${LicenseClassTable.colId}
    WHERE l.${LicenseTable.colDriverId} = ?
    ORDER BY l.${LicenseTable.colIsActive} DESC, l.${LicenseTable.colExpirationDate} DESC
  ''';

  static const getLicenseInfoByIdQuery =
      '''
    SELECT 
      l.${LicenseTable.colId},
      lc.${LicenseClassTable.colName},
      p.${PersonTable.colNationalNo},
      l.${LicenseTable.colIssueDate},
      l.${LicenseTable.colExpirationDate},
      l.${LicenseTable.colIsActive},
      l.${LicenseTable.colNotes},
      l.${LicenseTable.colIssueReason},
      l.${LicenseTable.colDriverId},
      TRIM(
          p.${PersonTable.colFirstName} || ' ' || 
          p.${PersonTable.colSecondName} || 
          COALESCE(' ' || p.${PersonTable.colThirdName}, '') || ' ' || 
          p.${PersonTable.colLastName}
      ) AS FullName,
      p.${PersonTable.colGender},
      p.${PersonTable.colDateOfBirth},
      p.${PersonTable.colImagePath}
    FROM ${LicenseTable.tableName} l
    INNER JOIN ${LicenseClassTable.tableName} lc 
      ON l.${LicenseTable.colLicenseClass} = lc.${LicenseClassTable.colId}
    INNER JOIN ${DriversTable.tableName} d 
      ON l.${LicenseTable.colDriverId} = d.${DriversTable.colDriverID}
    INNER JOIN ${PersonTable.tableName} p 
      ON d.${DriversTable.colPersonID} = p.${PersonTable.colId}
    WHERE l.${LicenseTable.colId} = ?
    LIMIT 1;
  ''';

  static const String getLicenseIdByLocalDLApplicationIdQuery =
      '''
  SELECT 
    l.${LicenseTable.colId}
  FROM ${ApplicationTable.tableName} a
  INNER JOIN ${LocalDrivingLicenseApplicationTable.tableName} ldla 
      ON a.${ApplicationTable.colId} = ldla.${LocalDrivingLicenseApplicationTable.colApplicationId}
  INNER JOIN ${LicenseTable.tableName} l 
      ON a.${ApplicationTable.colId} = l.${LicenseTable.colApplicationId}
  WHERE ldla.${LocalDrivingLicenseApplicationTable.colId} = ?
  ORDER BY l.${LicenseTable.colId} DESC
  LIMIT 1;
''';

  //   static const getLicenseIdByLocalDLApplicationIdQuery =
  //       '''
  //   SELECT
  //     l.${LicenseTable.colId}
  // FROM ${ApplicationTable.tableName} a
  // INNER JOIN ${LocalDrivingLicenseApplicationTable.tableName} ldla
  //     ON a.${ApplicationTable.colId} = ldla.${LocalDrivingLicenseApplicationTable.colApplicationId}
  // INNER JOIN ${LicenseTable.tableName} l
  //     ON a.${ApplicationTable.colId} = l.${LicenseTable.colApplicationId}
  // WHERE ldla.${LocalDrivingLicenseApplicationTable.colId} = ?;
  //     LIMIT 1;
  //   ''';
}
