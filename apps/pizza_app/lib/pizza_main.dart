import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/home_screen.dart';

class PizzaMain extends StatelessWidget {
  const PizzaMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomeScreen(),
    );
  }
}
