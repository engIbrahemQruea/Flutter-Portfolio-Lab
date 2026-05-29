import 'package:advanced/004_more_about_delegation/home_screen.dart';
import 'package:advanced/018_introduction_to_cryptography/main_cryptography_screen.dart';
import 'package:advanced/020_multithreading_isolate/main_isolate_screen.dart';
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
      // home: const MainEventScreen(),
      //home: const HomeScreen(),
     // home: const MainCryptographyScreen(),
      home: const MainIsolateScreen(),
    );
  }
}
