import 'package:advanced/022_responsive/main_responsive_screen.dart';
import 'package:advanced/022_responsive/models/data.dart' as data;
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
      // home: const MainAsynchronousScreen(),
      home:  FeedMainScreen(currentUser: data.user_0),
    );
  }
}
