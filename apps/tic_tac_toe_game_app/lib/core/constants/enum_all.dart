enum GameResult { inProgress, draw, playerX, playerO }

enum Player {
  playerX('assets/images/x.png'),
  playerO('assets/images/o.png'),
  playerQ('assets/images/question-mark-96.png');

  final String imagePath;

  const Player(this.imagePath);
}

class XOGameStatus {
  GameResult winner;
  bool isGameOver;
  int playCount;

  XOGameStatus({
    this.winner = GameResult.inProgress,
    this.isGameOver = false,
    this.playCount = 0,
  });
}
