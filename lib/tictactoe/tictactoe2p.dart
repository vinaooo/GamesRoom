// ignore_for_file:  unused_import

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:gamesroom/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:random_text_reveal/random_text_reveal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon/neon.dart';
import 'dart:math';
import '../const.dart';

Random random = Random();

int player1Score = 0;
int player2Score = 0;
Color playerColor = Colors.green;
String scoreName = 'Score';

class FixedNeonText extends StatelessWidget {
  const FixedNeonText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neon(
      text: scoreName,
      color: Colors.purple,
      fontSize: fontSize * 0.045,
      font: NeonFont.TextMeOne,
      flickeringText: true,
      flickeringLetters: [
        Random().nextInt(scoreName.length),
        Random().nextInt(scoreName.length)
      ],
    );
  }
}

class TicTacToe2PPage extends StatefulWidget {
  const TicTacToe2PPage({
    Key? key,
    required this.player1Name,
    required this.player1Icon,
    required this.player1Color,
    required this.player2Name,
    required this.player2Icon,
    required this.player2Color,
  }) : super(key: key);

  final String player1Name;
  final Icon player1Icon;
  final Color player1Color;
  final String player2Name;
  final Icon player2Icon;
  final Color player2Color;

  @override
  // ignore: library_private_types_in_public_api
  _TicTacToe2PPageState createState() => _TicTacToe2PPageState();
}

bool player1Turn = random.nextBool();
double fontSize = 0;

class _TicTacToe2PPageState extends State<TicTacToe2PPage> {
  List<List<String>> board =
      List.generate(3, (_) => List.generate(3, (_) => ''));

  void _resetBoard() {
    if (mounted) {
      setState(
        () {
          board = List.generate(3, (_) => List.generate(3, (_) => ''));
          // player1Turn = true;
        },
      );
    }
  }

  void _resetScore() {
    if (mounted) {
      setState(
        () {
          player1Score = 0;
          player2Score = 0;
        },
      );
    }
  }

  void _showWinnerAnimation(String winner) {
    String message;
    IconData icon = Icons.mood;
    Color color = Colors.green;

    if (winner == 'X') {
      setState(() {
        player1Score = player1Score + 1;
      });

      message = 'Player 1 Wins!';
    } else if (winner == 'o') {
      setState(() {
        player2Score = player2Score + 1;
      });
      message = 'Player 2 Wins!';
    } else {
      message = 'It\'s a Tie!';
      icon = Icons.sentiment_neutral;
      color = Colors.yellow.harmonizeWith(Colors.purple);
    }
    if (winner == 'X' || winner == 'o') {
      icon = Icons.mood;
      color = Colors.green.harmonizeWith(Colors.purple);
    }
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final bottomSheet = (screenWidth - 32);
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero),
            color: color,
          ),
          width: bottomSheet,
          height: 200.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  size: 50.0,
                  color: Colors.grey.harmonizeWith(
                      Colors.yellow.harmonizeWith(Colors.purple)),
                ),
                const SizedBox(height: 10.0),
                RandomTextReveal(
                  text: message,
                  initialText: "pknmerwemainmr",
                  duration: const Duration(milliseconds: 1500),
                  style: GoogleFonts.ubuntuMono(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                    shadows: [
                      const Shadow(
                        color: Colors.black,
                        offset: Offset(0.5, 0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  randomString: Source.alphabets,
                  curve: Curves.easeIn,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        );
      },
    ).whenComplete(
      () {
        _resetBoard();
      },
    );
  }

  void _markBox(int row, int col) {
    if (board[row][col] == '') {
      if (mounted) {
        setState(
          () {
            board[row][col] = player1Turn ? 'X' : 'o';
            player1Turn = !player1Turn;
          },
        );
      }
      _checkWinner();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _checkWinner() {
    List<List<String>> lines = [
      // horizontal
      [board[0][0], board[0][1], board[0][2]],
      [board[1][0], board[1][1], board[1][2]],
      [board[2][0], board[2][1], board[2][2]],
      // vertical
      [board[0][0], board[1][0], board[2][0]],
      [board[0][1], board[1][1], board[2][1]],
      [board[0][2], board[1][2], board[2][2]],
      // diagonal
      [board[0][0], board[1][1], board[2][2]],
      [board[0][2], board[1][1], board[2][0]],
    ];

    // check for winner
    for (List<String> line in lines) {
      if (line.every((item) => item == 'X')) {
        _showWinnerAnimation('X');
        return;
      } else if (line.every((item) => item == 'o')) {
        _showWinnerAnimation('o');
        return;
      }
    }

    // check for tie
    if (!board.any((row) => row.contains(''))) {
      _showWinnerAnimation('tie');
      return;
    }
  }

  BannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _resetScore();
  }

  Widget _buildBox(int row, int col, bool right, bool bottom) {
    return GestureDetector(
      onTap: () => _markBox(row, col),
      child: OrientationBuilder(
        builder: (context, orientation) {
          final screenWidth = MediaQuery.of(context).size.width;
          final boxSize = screenWidth * 0.3;
          return SizedBox(
            width: boxSize,
            height: boxSize,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                      color: right
                          ? Theme.of(context).dividerColor
                          : Colors.transparent),
                  bottom: BorderSide(
                      color: bottom
                          ? Theme.of(context).dividerColor
                          : Colors.transparent),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    board[row][col],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: board[row][col] == 'X' ? 1.5 : 0,
                      fontFamily: 'chalk',
                      fontSize: board[row][col] == 'X' ? 100 : 140,
                      color: board[row][col] == 'X'
                          ? player1Color.harmonizeWith(Colors.white)
                          : player2Color.harmonizeWith(Colors.transparent),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ThemeMode themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final heightSize = screenHeight * 0.00675;
    return MainPage(
      title: 'Tic Tac Toe',
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                scoreTable(context),
                const SizedBox(height: 10.0),
                SizedBox(
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        child: Wrap(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _buildBox(0, 0, true, true),
                                _buildBox(0, 1, true, true),
                                _buildBox(0, 2, false, true),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _buildBox(1, 0, true, true),
                                _buildBox(1, 1, true, true),
                                _buildBox(1, 2, false, true),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _buildBox(2, 0, true, false),
                                _buildBox(2, 1, true, false),
                                _buildBox(2, 2, false, false),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: heightSize),
                      if (player1Turn) const Text('X joga'),
                      if (!player1Turn) const Text('O joga'),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          minimumSize: const Size(50, 30),
                        ),
                        onPressed: _resetBoard,
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ),
                const Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(
                    height: 100,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget scoreTable(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    MediaQueryData queryData = MediaQuery.of(context);
    fontSize = queryData.size.height;
    return SizedBox(
      height: screenHeight * 0.26,
      child: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 2,
              //Theme.of(context).colorScheme.surfaceVariant,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: fontSize * 0.14,
                        ),
                        const FixedNeonText(),
                        SizedBox(
                          width: fontSize * 0.14,
                          child: TextButton(
                            onPressed: () {
                              _resetScore();
                            },
                            child: Text(
                              'Reset Score',
                              style: TextStyle(
                                fontSize: fontSize * 0.012,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.player1Name,
                            style: TextStyle(
                              fontSize: fontSize * 0.024,
                              color: Colors.white,
                              shadows: const [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                          ),
                          RandomTextReveal(
                            text: '$player1Score',
                            initialText: "7",
                            duration: const Duration(milliseconds: 1000),
                            style: TextStyle(
                              fontFamily: 'lcddot',
                              fontSize: fontSize * 0.09,
                              height: 0.8,
                              color: player1Color,
                            ),
                            randomString: Source.digits,
                            curve: Curves.easeIn,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.player2Name,
                            style: TextStyle(
                              fontSize: fontSize * 0.024,
                              color: Colors.white,
                              shadows: const [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                          ),
                          RandomTextReveal(
                            text: '$player2Score',
                            initialText: "3",
                            duration: const Duration(milliseconds: 1200),
                            style: TextStyle(
                              fontFamily: 'lcddot',
                              fontSize: fontSize * 0.09,
                              height: 0.8,
                              color: player2Color,
                            ),
                            randomString: Source.digits,
                            curve: Curves.easeIn,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  //bannerAds(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
