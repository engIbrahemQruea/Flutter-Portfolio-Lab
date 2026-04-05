import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game_app/features/screens/home/tic_tac_game_screen.dart';

class TicTacGameMain extends StatelessWidget {
  const TicTacGameMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe Game',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const TicTacGameScreen(),
    );
  }
}
