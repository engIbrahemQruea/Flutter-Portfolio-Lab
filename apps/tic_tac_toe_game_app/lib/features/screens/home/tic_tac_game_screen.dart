import 'package:flutter/material.dart';

class TicTacGameScreen extends StatelessWidget {
  const TicTacGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: const Center(child: Text('Welcome to the Tic Tac Toe Game!')),
    );
  }
}
