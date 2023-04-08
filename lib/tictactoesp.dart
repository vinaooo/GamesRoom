//whats the first line called

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Player {
  final String symbol;

  Player(this.symbol);
}

class Game {
  final List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));
  final Player playerX = Player('X');
  final Player playerO = Player('O');
  Player currentPlayer = Player('X');

  void play(int row, int col) {
    if (board[row][col].isNotEmpty) {
      throw Exception('Posição ocupada');
    }
    board[row][col] = currentPlayer.symbol;
    if (checkWinner()) {
      if (kDebugMode) {
        print('O jogador ${currentPlayer.symbol} venceu!');
      }
      reset();
    } else if (checkDraw()) {
      if (kDebugMode) {
        print('Empate!');
      }
      reset();
    } else {
      currentPlayer = currentPlayer == playerX ? playerO : playerX;
      if (currentPlayer == playerO) {
        playComputer();
      }
    }
  }

  void playComputer() {
    final rng = Random();
    int row, col;
    do {
      row = rng.nextInt(3);
      col = rng.nextInt(3);
    } while (board[row][col].isNotEmpty);
    play(row, col);
  }

  bool checkWinner() {
    for (var i = 0; i < 3; i++) {
      if (board[i][0].isNotEmpty &&
          board[i][0] == board[i][1] &&
          board[i][0] == board[i][2]) {
        return true;
      }
      if (board[0][i].isNotEmpty &&
          board[0][i] == board[1][i] &&
          board[0][i] == board[2][i]) {
        return true;
      }
    }
    if (board[0][0].isNotEmpty &&
        board[0][0] == board[1][1] &&
        board[0][0] == board[2][2]) {
      return true;
    }
    if (board[0][2].isNotEmpty &&
        board[0][2] == board[1][1] &&
        board[0][2] == board[2][0]) {
      return true;
    }
    return false;
  }

  bool checkDraw() {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  void reset() {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        board[i][j] = '';
      }
    }
    currentPlayer = playerX;
  }
}

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  final Game game = Game();

  void _handleTap(int row, int col) {
    setState(() {
      try {
        game.play(row, col);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  Widget _buildSquare(int row, int col) {
    return GestureDetector(
      onTap: game.board[row][col].isEmpty ? () => _handleTap(row, col) : null,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: row == 0 ? const BorderSide() : BorderSide.none,
            left: col == 0 ? const BorderSide() : BorderSide.none,
            bottom: row == 2 ? const BorderSide() : BorderSide.none,
            right: col == 2 ? const BorderSide() : BorderSide.none,
          ),
        ),
        child: Center(
          child: Text(
            game.board[row][col],
            style: const TextStyle(fontSize: 64),
          ),
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(9, (index) {
        final row = index ~/ 3;
        final col = index % 3;
        return _buildSquare(row, col);
      }),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      child: const Text('Reset'),
      onPressed: () {
        setState(() {
          game.reset();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildBoard(),
          ),
          _buildResetButton(),
        ],
      ),
    );
  }
}
