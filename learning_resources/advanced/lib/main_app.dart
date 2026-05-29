import 'package:advanced/021_intro_to_asynchronous/main_asynchronous_screen.dart';
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
      // home: const MainIsolateScreen(),
      home: const MainAsynchronousScreen(),
    );
  }
}
