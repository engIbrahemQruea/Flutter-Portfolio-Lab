import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/tests/test_types/data/data_sources/test_type_table.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:sqflite/sqflite.dart';

class TestAppointmentsTable implements AppTable {
  static const String tableName = 'TestAppointments';

  static const String colTestAppointmentID = 'TestAppointmentID';
  static const String colTestTypeID = 'TestTypeID';
  static const String colLocalDrivingLicenseApplicationID =
      'LocalDrivingLicenseApplicationID';
  static const String colAppointmentDate = 'AppointmentDate';
  static const String colPaidFees = 'PaidFees';
  static const String colCreatedByUserID = 'CreatedByUserID';
  static const String colIsLocked = 'IsLocked';
  static const String colRetakeTestApplicationID = 'RetakeTestApplicationID';

  static const String createTableQuery =
      '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $colTestAppointmentID INTEGER PRIMARY KEY AUTOINCREMENT,
      $colTestTypeID INTEGER NOT NULL,
      $colLocalDrivingLicenseApplicationID INTEGER NOT NULL,
      $colAppointmentDate TEXT NOT NULL,
      $colPaidFees REAL NOT NULL,
      $colCreatedByUserID INTEGER NOT NULL,
      $colIsLocked INTEGER NOT NULL DEFAULT 0,
      $colRetakeTestApplicationID INTEGER,
      FOREIGN KEY ($colTestTypeID) REFERENCES ${TestTypeTable.tableName}(${TestTypeTable.colId}),
      FOREIGN KEY ($colLocalDrivingLicenseApplicationID) REFERENCES ${LocalDrivingLicenseApplicationTable.tableName}(${LocalDrivingLicenseApplicationTable.colId}),
      FOREIGN KEY ($colCreatedByUserID) REFERENCES ${UserTable.tableName}(${UserTable.colUserId}),
      FOREIGN KEY ($colRetakeTestApplicationID) REFERENCES ${ApplicationTable.tableName}(${ApplicationTable.colId})
    );
  ''';

  static const List<
    ({
      int id,
      int testTypeId,
      int localAppId,
      String appointmentDate,
      double paidFees,
      int createdByUserId,
      bool isLocked,
      int? retakeAppId,
    })
  >
  seedRecords = [
    (
      id: 108,
      testTypeId: 1,
      localAppId: 36,
      appointmentDate: '2023-10-07 10:46:00',
      paidFees: 10.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 109,
      testTypeId: 1,
      localAppId: 36,
      appointmentDate: '2023-10-20 11:00:00',
      paidFees: 10.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: 111,
    ),
    (
      id: 110,
      testTypeId: 2,
      localAppId: 36,
      appointmentDate: '2023-10-07 11:01:00',
      paidFees: 20.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 111,
      testTypeId: 2,
      localAppId: 36,
      appointmentDate: '2023-10-07 11:04:00',
      paidFees: 20.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: 112,
    ),
    (
      id: 112,
      testTypeId: 3,
      localAppId: 36,
      appointmentDate: '2023-10-07 11:05:00',
      paidFees: 30.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 113,
      testTypeId: 1,
      localAppId: 37,
      appointmentDate: '2023-10-07 11:07:00',
      paidFees: 10.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 114,
      testTypeId: 2,
      localAppId: 37,
      appointmentDate: '2023-10-07 11:08:00',
      paidFees: 20.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 115,
      testTypeId: 3,
      localAppId: 37,
      appointmentDate: '2023-10-07 11:08:00',
      paidFees: 30.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 116,
      testTypeId: 1,
      localAppId: 38,
      appointmentDate: '2023-10-07 11:17:00',
      paidFees: 10.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 117,
      testTypeId: 1,
      localAppId: 38,
      appointmentDate: '2023-10-07 11:17:00',
      paidFees: 10.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: 116,
    ),
    (
      id: 118,
      testTypeId: 2,
      localAppId: 38,
      appointmentDate: '2023-10-07 11:31:00',
      paidFees: 20.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 119,
      testTypeId: 2,
      localAppId: 38,
      appointmentDate: '2023-10-07 11:32:00',
      paidFees: 20.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: 117,
    ),
    (
      id: 120,
      testTypeId: 3,
      localAppId: 38,
      appointmentDate: '2023-10-07 11:39:00',
      paidFees: 30.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 121,
      testTypeId: 3,
      localAppId: 38,
      appointmentDate: '2023-10-07 11:39:00',
      paidFees: 30.00,
      createdByUserId: 1,
      isLocked: false,
      retakeAppId: 118,
    ),
    (
      id: 122,
      testTypeId: 1,
      localAppId: 41,
      appointmentDate: '2023-10-10 21:44:00',
      paidFees: 10.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 123,
      testTypeId: 1,
      localAppId: 41,
      appointmentDate: '2023-10-09 21:48:00',
      paidFees: 10.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: 123,
    ),
    (
      id: 124,
      testTypeId: 2,
      localAppId: 41,
      appointmentDate: '2023-10-19 21:51:00',
      paidFees: 20.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 125,
      testTypeId: 3,
      localAppId: 41,
      appointmentDate: '2023-10-20 21:52:00',
      paidFees: 35.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: null,
    ),
    (
      id: 126,
      testTypeId: 3,
      localAppId: 41,
      appointmentDate: '2023-10-09 21:52:00',
      paidFees: 35.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: 124,
    ),
    (
      id: 127,
      testTypeId: 3,
      localAppId: 41,
      appointmentDate: '2023-10-21 21:53:00',
      paidFees: 35.00,
      createdByUserId: 1,
      isLocked: true,
      retakeAppId: 125,
    ),
  ];

  static Future<void> seedData(Database db) async {
    final batch = db.batch();

    for (final item in seedRecords) {
      batch.insert(tableName, {
        colTestAppointmentID: item.id,
        colTestTypeID: item.testTypeId,
        colLocalDrivingLicenseApplicationID: item.localAppId,
        colAppointmentDate: item.appointmentDate,
        colPaidFees: item.paidFees,
        colCreatedByUserID: item.createdByUserId,
        colIsLocked: item.isLocked ? 1 : 0,
        colRetakeTestApplicationID: item.retakeAppId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createTableQuery);
    await seedData(db);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
