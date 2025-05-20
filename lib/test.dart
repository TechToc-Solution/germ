import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(const TicTacToeApp());

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  FlutterTts flutterTts = FlutterTts();
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  bool gameOver = false;

  void resetGame() {
    setState(() {
      board = List.filled(9, ''); // Clear the game board
      currentPlayer = 'X'; // Set the starting player to 'X'
      gameOver = false; // Reset the game over status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe with AI'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return buildGridTile(index);
              },
            ),
          ),
          Text(
            gameOver ? 'Game Over!' : 'Current Player: $currentPlayer',
            style: const TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              resetGame();
            },
            child: const Text('Reset Game'),
          ),
        ],
      ),
    );
  }

  Widget buildGridTile(int index) {
    return GestureDetector(
      onTap: () {
        if (!gameOver && board[index] == '') {
          setState(() {
            board[index] = currentPlayer;
            if (checkForWinner(currentPlayer)) {
              gameOver = true;
              flutterTts.speak('Player $currentPlayer wins!');
            } else if (board.every((cell) => cell != '')) {
              gameOver = true;
              flutterTts.speak('It\'s a draw!');
            } else {
              currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
              if (currentPlayer == 'O') {
                makeAiMove();
              }
            }
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
          child: Text(
            board[index],
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }

  bool checkForWinner(String player) {
    for (var i = 0; i < 3; i++) {
      if (board[i] == player &&
          board[i + 3] == player &&
          board[i + 6] == player) {
        return true;
      }
      if (board[i * 3] == player &&
          board[i * 3 + 1] == player &&
          board[i * 3 + 2] == player) {
        return true;
      }
    }
    if (board[0] == player && board[4] == player && board[8] == player) {
      return true;
    }
    if (board[2] == player && board[4] == player && board[6] == player) {
      return true;
    }
    return false;
  }

  void makeAiMove() {
    int bestMove = -1;
    int bestScore = -1000;

    for (var i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'O';
        int score = minimax(board, 0, false);
        board[i] = '';

        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    if (bestMove != -1) {
      board[bestMove] = 'O';
      if (checkForWinner('O')) {
        gameOver = true;
        flutterTts.speak('AI wins!');
      } else if (board.every((cell) => cell != '')) {
        gameOver = true;
        flutterTts.speak('It\'s a draw!');
      } else {
        currentPlayer = 'X';
      }
    }
  }

  int minimax(List<String> currentBoard, int depth, bool isMaximizing) {
    if (checkForWinner('O')) {
      return 1;
    }
    if (checkForWinner('X')) {
      return -1;
    }
    if (currentBoard.every((cell) => cell != '')) {
      return 0;
    }

    int bestScore = isMaximizing ? -1000 : 1000;

    for (var i = 0; i < currentBoard.length; i++) {
      if (currentBoard[i] == '') {
        currentBoard[i] = isMaximizing ? 'O' : 'X';
        int score = minimax(currentBoard, depth + 1, !isMaximizing);
        currentBoard[i] = '';
        if (isMaximizing) {
          bestScore = bestScore > score ? bestScore : score;
        } else {
          bestScore = bestScore < score ? bestScore : score;
        }
      }
    }

    return bestScore;
  }
}
