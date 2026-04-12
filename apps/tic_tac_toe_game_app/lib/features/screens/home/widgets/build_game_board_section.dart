import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game_app/features/screens/home/data/logic/x_o_game_provider.dart';
import 'package:tic_tac_toe_game_app/features/screens/home/widgets/build_player_image.dart';
import 'package:tic_tac_toe_game_app/features/screens/home/widgets/tic_tac_toe_grid_painter.dart';

class BuildGameBoard extends StatelessWidget {
  const BuildGameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: TicTacToeGridPainter())),
        Positioned.fill(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              var gameState = Provider.of<XOGameProvider>(context);
              return GestureDetector(
                onTap: () {
                 gameState.makeMove(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Center(
                    child: BuildPlayerImage(player: gameState.board[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
