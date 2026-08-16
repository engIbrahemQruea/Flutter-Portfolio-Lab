import 'package:dvld/core/database/app_table.dart';
import 'package:sqflite_common/sqlite_api.dart';

class TestTypeTable implements AppTable {
  static const String tableName = 'test_types';

  static const String colId = 'test_type_id';
  static const String colTitle = 'test_type_title';
  static const String colDescription = 'test_type_description';
  static const String colFees = 'test_type_fees';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colTitle TEXT NOT NULL,
      $colDescription TEXT NOT NULL,
      $colFees REAL NOT NULL DEFAULT 0.0
    )
  ''';

  static const String seedTestTypesQuery =
      '''
    INSERT INTO $tableName ($colId, $colTitle, $colDescription, $colFees) VALUES
    (
      1, 
      'Vision Test', 
      'This assesses the applicant''s visual acuity to ensure they have sufficient vision to drive safely.', 
      10.00
    ),
    (
      2, 
      'Written (Theory) Test', 
      'This test assesses the applicant''s knowledge of traffic rules, road signs, and driving regulations. It typically consists of multiple-choice questions, and the applicant must select the correct answer(s). The written test aims to ensure that the applicant understands the rules of the road and can apply them in various driving scenarios.', 
      20.00
    ),
    (
      3, 
      'Practical (Street) Test', 
      'This test evaluates the applicant''s driving skills and ability to operate a motor vehicle safely on public roads. A licensed examiner accompanies the applicant in the vehicle and observes their driving performance.', 
      35.00
    );
  ''';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createTableQuery);
    await db.execute(seedTestTypesQuery);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
