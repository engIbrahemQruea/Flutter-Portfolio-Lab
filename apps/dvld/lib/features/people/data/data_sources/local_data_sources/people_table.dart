



import 'package:sqflite/sqflite.dart';
import 'package:dvld/core/database/app_table.dart';

class PeopleTable implements AppTable {
  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(CountryTable.createTableQuery);
    await db.execute(CountryTable.seedCountriesQuery);
    await db.execute(PersonTable.createTableQuery);
    await db.execute(PersonTable.seedPeopleQuery);
  }
  
  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}

class CountryTable {
  static const String tableName = 'countries';
  static const String colId = 'country_id';
  static const String colName = 'country_name';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colName TEXT NOT NULL
    )
  ''';

  static const String seedCountriesQuery =
      '''
    INSERT INTO $tableName ($colId, $colName) VALUES
    (1, 'Afghanistan'), (2, 'Albania'), (3, 'Algeria'), (4, 'Andorra'), (5, 'Angola'),
    (6, 'Antigua and Barbuda'), (7, 'Argentina'), (8, 'Armenia'), (9, 'Austria'), (10, 'Azerbaijan'),
    (11, 'Bahrain'), (12, 'Bangladesh'), (13, 'Barbados'), (14, 'Belarus'), (15, 'Belgium'),
    (16, 'Belize'), (17, 'Benin'), (18, 'Bhutan'), (19, 'Bolivia'), (20, 'Bosnia and Herzegovina'),
    (21, 'Botswana'), (22, 'Brazil'), (23, 'Brunei'), (24, 'Bulgaria'), (25, 'Burkina Faso'),
    (26, 'Burundi'), (27, 'Cabo Verde'), (28, 'Cambodia'), (29, 'Cameroon'), (30, 'Canada'),
    (31, 'Central African Republic'), (32, 'Chad'), (33, 'Channel Islands'), (34, 'Chile'), (35, 'China'),
    (36, 'Colombia'), (37, 'Comoros'), (38, 'Congo'), (39, 'Costa Rica'), (40, 'Côte d''Ivoire'),
    (41, 'Croatia'), (42, 'Cuba'), (43, 'Cyprus'), (44, 'Czech Republic'), (45, 'Denmark'),
    (46, 'Djibouti'), (47, 'Dominica'), (48, 'Dominican Republic'), (49, 'DR Congo'), (50, 'Ecuador'),
    (51, 'Egypt'), (52, 'El Salvador'), (53, 'Equatorial Guinea'), (54, 'Eritrea'), (55, 'Estonia'),
    (56, 'Eswatini'), (57, 'Ethiopia'), (58, 'Faeroe Islands'), (59, 'Finland'), (60, 'France'),
    (61, 'French Guiana'), (62, 'Gabon'), (63, 'Gambia'), (64, 'Georgia'), (65, 'Germany'),
    (66, 'Ghana'), (67, 'Gibraltar'), (68, 'Greece'), (69, 'Grenada'), (70, 'Guatemala'),
    (71, 'Guinea'), (72, 'Guinea-Bissau'), (73, 'Guyana'), (74, 'Haiti'), (75, 'Holy See'),
    (76, 'Honduras'), (77, 'Hong Kong'), (78, 'Hungary'), (79, 'Iceland'), (80, 'India'),
    (81, 'Indonesia'), (82, 'Iran'), (83, 'Iraq'), (84, 'Ireland'), (85, 'Isle of Man'),
    (86, 'Israel'), (87, 'Italy'), (88, 'Jamaica'), (89, 'Japan'), (90, 'Jordan'),
    (91, 'Kazakhstan'), (92, 'Kenya'), (93, 'Kuwait'), (94, 'Kyrgyzstan'), (95, 'Laos'),
    (96, 'Latvia'), (97, 'Lebanon'), (98, 'Lesotho'), (99, 'Liberia'), (100, 'Libya'),
    (101, 'Liechtenstein'), (102, 'Lithuania'), (103, 'Luxembourg'), (104, 'Macao'), (105, 'Madagascar'),
    (106, 'Malawi'), (107, 'Malaysia'), (108, 'Maldives'), (109, 'Mali'), (110, 'Malta'),
    (111, 'Mauritania'), (112, 'Mauritius'), (113, 'Mayotte'), (114, 'Mexico'), (115, 'Moldova'),
    (116, 'Monaco'), (117, 'Mongolia'), (118, 'Montenegro'), (119, 'Morocco'), (120, 'Mozambique'),
    (121, 'Myanmar'), (122, 'Namibia'), (123, 'Nepal'), (124, 'Netherlands'), (125, 'Nicaragua'),
    (126, 'Niger'), (127, 'Nigeria'), (128, 'North Korea'), (129, 'North Macedonia'), (130, 'Norway'),
    (131, 'Oman'), (132, 'Pakistan'), (133, 'Panama'), (134, 'Paraguay'), (135, 'Peru'),
    (136, 'Philippines'), (137, 'Poland'), (138, 'Portugal'), (139, 'Qatar'), (140, 'Réunion'),
    (141, 'Romania'), (142, 'Russia'), (143, 'Rwanda'), (144, 'Saint Helena'), (145, 'Saint Kitts and Nevis'),
    (146, 'Saint Lucia'), (147, 'Saint Vincent and the Grenadines'), (148, 'San Marino'), (149, 'Sao Tome & Principe'), (150, 'Saudi Arabia'),
    (151, 'Senegal'), (152, 'Serbia'), (153, 'Seychelles'), (154, 'Sierra Leone'), (155, 'Singapore'),
    (156, 'Slovakia'), (157, 'Slovenia'), (158, 'Somalia'), (159, 'South Africa'), (160, 'South Korea'),
    (161, 'South Sudan'), (162, 'Spain'), (163, 'Sri Lanka'), (164, 'State of Palestine'), (165, 'Sudan'),
    (166, 'Suriname'), (167, 'Sweden'), (168, 'Switzerland'), (169, 'Syria'), (170, 'Taiwan'),
    (171, 'Tajikistan'), (172, 'Tanzania'), (173, 'Thailand'), (174, 'The Bahamas'), (175, 'Timor-Leste'),
    (176, 'Togo'), (177, 'Trinidad and Tobago'), (178, 'Tunisia'), (179, 'Turkey'), (180, 'Turkmenistan'),
    (181, 'Uganda'), (182, 'Ukraine'), (183, 'United Arab Emirates'), (184, 'United Kingdom'), (185, 'United States'),
    (186, 'Uruguay'), (187, 'Uzbekistan'), (188, 'Venezuela'), (189, 'Vietnam'), (190, 'Western Sahara'),
    (191, 'Yemen'), (192, 'Zambia'), (193, 'Zimbabwe');
  ''';
}

class PersonTable {
  static const String tableName = 'people';
  static const String colId = 'person_id';
  static const String colNationalNo = 'national_no';
  static const String colFirstName = 'first_name';
  static const String colSecondName = 'second_name';
  static const String colThirdName = 'third_name';
  static const String colLastName = 'last_name';
  static const String colDateOfBirth = 'date_of_birth';
  static const String colGender = 'gender';
  static const String colAddress = 'address';
  static const String colPhone = 'phone';
  static const String colEmail = 'email';
  static const String colCountryId = 'nationality_country_id';
  static const String colImagePath = 'image_path';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colNationalNo TEXT NOT NULL UNIQUE,
      $colFirstName TEXT NOT NULL,
      $colSecondName TEXT NOT NULL,
      $colThirdName TEXT,
      $colLastName TEXT NOT NULL,
      $colDateOfBirth TEXT NOT NULL,
      $colGender INTEGER NOT NULL DEFAULT 0,
      $colAddress TEXT NOT NULL,
      $colPhone TEXT NOT NULL,
      $colEmail TEXT,
      $colCountryId INTEGER NOT NULL,
      $colImagePath TEXT,
      FOREIGN KEY ($colCountryId) REFERENCES countries (country_id) 
        ON UPDATE CASCADE ON DELETE RESTRICT
    )
  ''';

  static const String seedPeopleQuery =
      '''
    INSERT INTO $tableName (
      $colId, $colNationalNo, $colFirstName, $colSecondName, $colThirdName, $colLastName, 
      $colDateOfBirth, $colGender, $colAddress, $colPhone, $colEmail, $colCountryId, $colImagePath
    ) VALUES
    (1, 'N1', 'Mohammed1', 'Saqer', 'Mussa', 'Abu-Hadhoud', '1977-11-06 00:00:00.000', 0, 'Amman Jubaiha1', '999876', 'Msaqer@gmail.com', 90, NULL),
    (1023, 'N2', 'Omar', 'Mohammed', 'Saqer', 'Abu-Hadhoud', '2005-06-01 20:13:44.000', 0, 'Amman 20091-Street', '07992992', 'Omar@g.com', 90, NULL),
    (1024, 'N3', 'Hamzeh', 'Mohammed', 'Saqer', 'Abu-Hadhoud', '2005-09-23 21:05:06.873', 0, 'Amman', '234566', 'H@H.com', 90, NULL),
    (1025, 'n4', 'Khalid', 'ALi', 'Maher', 'hamed', '2005-09-24 13:32:14.183', 0, 'Amman - Uni street 8938', '566543', 'Kh@k.com', 90, NULL),
    (1027, 'uu', 'u', 'uu', 'uu', 'uu', '2005-10-09 14:14:07.923', 0, 'ggg', '7775522', NULL, 90, NULL),
    (1028, 'N5', 'Alia', 'Khalil', 'Sami', 'Ahmed', '2005-10-09 19:30:28.893', 1, 'Amman 83883', '234234', NULL, 90, NULL),
    (1029, 'N10', 'Mahmoud', 'Omar', 'Ali', 'Almajed', '2005-10-09 21:07:38.747', 0, 'Amman - 209928 -1', '0729928822', 'M@Gmail.com', 90, NULL);
  ''';
}
