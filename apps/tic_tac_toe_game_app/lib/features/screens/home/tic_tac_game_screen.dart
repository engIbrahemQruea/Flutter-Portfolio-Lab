import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game_app/features/screens/home/widgets/build_game_board_section.dart';
import 'package:tic_tac_toe_game_app/features/screens/home/widgets/build_info_section.dart';
import 'package:tic_tac_toe_game_app/features/screens/home/widgets/tic_tac_toe_grid_painter.dart';

class TicTacGameScreen extends StatelessWidget {
  const TicTacGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            BuildInfoSection(),
            const SizedBox(width: 60),
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(color: Colors.black),
              child: BuildGameBoard(),
            ),
          ],
        ),
      ),
    );
  }
}
