import 'package:advanced/001_send_data_between_forms/screen_one.dart';
import 'package:advanced/002_user_controls/main_user_screen.dart';
import 'package:advanced/003_events_callback_function/main_event_screen.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      //home: const ScreenOne(),
      //home: const MainUserScreen(),
      home: const MainEventScreen(),
    );
  }
}
