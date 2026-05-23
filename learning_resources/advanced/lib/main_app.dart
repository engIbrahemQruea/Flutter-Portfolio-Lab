import 'package:advanced/004_more_about_delegation/home_screen.dart';
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
      home: const HomeScreen(),
    );
  }
}
