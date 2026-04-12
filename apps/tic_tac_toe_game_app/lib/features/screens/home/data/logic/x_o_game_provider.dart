import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game_app/core/constants/enum_all.dart';

class XOGameProvider with ChangeNotifier {
  List<Player> board = List.filled(9, Player.playerQ);
  Player currentPlayer = Player.playerX;
  XOGameStatus gameStatus = XOGameStatus();

  bool _checkCombination(int a, int b, int c) {
    if (board[a] != Player.playerQ &&
        board[a] == board[b] &&
        board[b] == board[c]) {
      gameStatus.winner = board[a] == Player.playerX
          ? GameResult.playerX
          : GameResult.playerO;
      gameStatus.isGameOver = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (_checkCombination(pattern[0], pattern[1], pattern[2])) {
        return;
      }
    }

    if (gameStatus.playCount == 9 && !gameStatus.isGameOver) {
      gameStatus.winner = GameResult.draw;
      gameStatus.isGameOver = true;
      notifyListeners();
    }
  }

  void makeMove(int index) {
    if (board[index] == Player.playerQ && !gameStatus.isGameOver) {
      board[index] = currentPlayer;
      gameStatus.playCount++;
      checkWinner();
      if (!gameStatus.isGameOver) {
        currentPlayer = currentPlayer == Player.playerX
            ? Player.playerO
            : Player.playerX;
        notifyListeners();
      }
    }
  }

  void resetGame() {
    board = List.filled(9, Player.playerQ);
    currentPlayer = Player.playerX;
    gameStatus = XOGameStatus();
    notifyListeners();
  }
}
