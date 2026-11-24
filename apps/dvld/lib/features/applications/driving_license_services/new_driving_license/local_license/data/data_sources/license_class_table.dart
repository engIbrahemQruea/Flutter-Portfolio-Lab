import 'package:dvld/core/database/app_table.dart';
import 'package:sqflite/sqflite.dart';

class LicenseClassTable implements AppTable {
  static const String tableName = 'license_classes';

  static const String colId = 'license_class_id';
  static const String colName = 'class_name';
  static const String colDescription = 'class_description';
  static const String colMinAge = 'minimum_allowed_age';
  static const String colDefaultValidity = 'default_validity_length';
  static const String colFees = 'class_fees';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colName TEXT NOT NULL,
      $colDescription TEXT NOT NULL,
      $colMinAge INTEGER NOT NULL DEFAULT 18,
      $colDefaultValidity INTEGER NOT NULL DEFAULT 1,
      $colFees REAL NOT NULL DEFAULT 0.0
    )
  ''';

  static const String seedLicenseClassesQuery =
      '''
    INSERT INTO $tableName (
      $colId, 
      $colName, 
      $colDescription, 
      $colMinAge, 
      $colDefaultValidity, 
      $colFees
    ) VALUES
    (1, 'Class 1 - Small Motorcycle', 'It allows the driver to drive small motorcycles, It is suitable for motorcycles with small capacity and limited power.', 18, 5, 15.00),
    (2, 'Class 2 - Heavy Motorcycle License', 'Heavy Motorcycle License (Large Motorcycle License)', 21, 5, 30.00),
    (3, 'Class 3 - Ordinary driving license', 'Ordinary driving license (car licence)', 18, 10, 20.00),
    (4, 'Class 4 - Commercial', 'Commercial driving license (taxi/limousine)', 21, 10, 200.00),
    (5, 'Class 5 - Agricultural', 'Agricultural and work vehicles used in farming or construction, (tractors / tillage machinery)', 21, 10, 50.00),
    (6, 'Class 6 - Small and medium bus', 'Small and medium bus license', 21, 10, 250.00),
    (7, 'Class 7 - Truck and heavy vehicle', 'Truck and heavy vehicle license', 21, 10, 300.00);
  ''';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createTableQuery);
    await db.execute(seedLicenseClassesQuery);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
