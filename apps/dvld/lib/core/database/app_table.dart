import 'package:sqflite/sqflite.dart';

abstract class AppTable {
  Future<void> onCreate(Database db, int version);
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {}
}