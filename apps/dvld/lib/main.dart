import 'dart:io';

import 'package:dvld/core/di/dependency_injection.dart';
import 'package:dvld/dvld_app.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  await setupGetIt();
  runApp(const DvldApp());
}
