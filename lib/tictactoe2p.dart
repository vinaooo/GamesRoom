// ignore_for_file: avoid_print
import 'dart:math';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:random_text_reveal/random_text_reveal.dart';

import 'ad_helper.dart';

int player1Score = 0;
int player2Score = 0;

class TicTacToe2PPage extends StatefulWidget {
  const TicTacToe2PPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TicTacToe2PPageState createState() => _TicTacToe2PPageState();
}

class _TicTacToe2PPageState extends State<TicTacToe2PPage> {
  List<List<String>> board =
      List.generate(3, (_) => List.generate(3, (_) => ''));

  bool player1Turn = true;

  void _resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.generate(3, (_) => ''));
      player1Turn = true;
    });
  }

  void _showWinnerAnimation(String winner) {
    String message;
    IconData icon;
    Color color;

    if (winner == 'X') {
      player1Score++;
      message = 'Player 1 Wins!';
      icon = Icons.mood;
      color = Colors.green;
    } else if (winner == 'O') {
      player2Score++;
      message = 'Player 2 Wins!';
      icon = Icons.mood;
      color = const ColorScheme.dark().errorContainer;
    } else {
      message = 'It\'s a Tie!';
      icon = Icons.sentiment_neutral;
      color = Colors.yellow;
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
                  color: Colors.white,
                ),
                const SizedBox(height: 10.0),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
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

    setState(() {
      player1Turn = true;
    });
  }

  void _markBox(int row, int col) {
    if (board[row][col] == '') {
      setState(() {
        board[row][col] = player1Turn ? 'X' : 'O';
        player1Turn = !player1Turn;
      });

      _checkWinner();
    }
  }

  @override
  void dispose() {
    bannerAd?.dispose();
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
        //_disableBoard();
        return;
      } else if (line.every((item) => item == 'O')) {
        _showWinnerAnimation('O');
        //_disableBoard();
        return;
      }
    }

    // check for tie
    if (!board.any((row) => row.contains(''))) {
      _showWinnerAnimation('tie');
      //_disableBoard();
      return;
    }
  }

  BannerAd? bannerAd;
  @override
  void initState() {
    super.initState();
    _resetScore();
    if (Platform.isAndroid) {
      BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(
          keywords: <String>[],
        ),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              bannerAd = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Releases an ad resource when it fails to load
            ad.dispose();
            print(
                'Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
      ).load();
    }
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
              child: Center(
                child: Text(
                  board[row][col],
                  style: const TextStyle(
                      fontSize: 80,
                      color: Color.fromARGB(255, 238, 187, 112),
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(0.3, 0.3),
                          blurRadius: 7,
                        ),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final heightSize = screenHeight * 0.00675;
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          theme: ThemeData(
            brightness: const ColorScheme.light().brightness,
            useMaterial3: true,
          ),
          home: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text('A Véia'),
              ),
              body: FutureBuilder<void>(
                  future: _initGoogleMobileAds(),
                  builder: (context, AsyncSnapshot<void> snapshot) {
                    return Column(
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
                                      color: const Color.fromARGB(
                                          255, 84, 84, 116),
                                      elevation: 5,
                                      child: Wrap(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              _buildBox(0, 0, true, true),
                                              _buildBox(0, 1, true, true),
                                              _buildBox(0, 2, false, true),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              _buildBox(1, 0, true, true),
                                              _buildBox(1, 1, true, true),
                                              _buildBox(1, 2, false, true),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        minimumSize:
                                            const Size(50, 30), //////// HERE
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
                                  ))
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        );
      },
    );
  }

  Widget scoreTable(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    MediaQueryData queryData = MediaQuery.of(context);
    double fontSize = queryData.size.height;
    return SizedBox(
      height: screenHeight * 0.26,
      child: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 5,
              color: const Color.fromARGB(255, 138, 140, 155),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: fontSize * 0.14,
                        ),
                        Text(
                          'Score',
                          style: TextStyle(
                            fontSize: fontSize * 0.045,
                            color: Colors.white,
                            shadows: const [
                              Shadow(
                                color: Colors.purple,
                                offset: Offset(0, 0),
                                blurRadius: 60,
                              )
                            ],
                          ),
                        ),
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
                            'Player 1',
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
                          Text(
                            player1Score.toString(),
                            style: TextStyle(
                              fontFamily: 'lcddot',
                              fontSize: fontSize * 0.09,
                              height: 0.8,
                              color: const Color.fromARGB(255, 239, 184, 16),
                              shadows: const [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Player 2',
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
                            text: player2Score.toString(),
                            initialText: "0D",
                            duration: const Duration(seconds: 1),
                            style: TextStyle(
                              fontFamily: 'lcddot',
                              fontSize: fontSize * 0.09,
                              height: 0.8,
                              color: const Color.fromARGB(255, 239, 184, 16),
                              shadows: const [
                                Shadow(
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
                        ],
                      ),
                    ],
                  ),
                  bannerAds(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetScore() {
    setState(() {
      player1Score = 0;
      player2Score = 0;
    });
  }

  static bannerAds(BuildContext context) {
    return Builder(builder: (ctx) {
      final BannerAd myBanner = BannerAd(
        adUnitId: 'ca-app-pub-4860380403931913/4313648864',
        request: const AdRequest(),
        listener: const BannerAdListener(),
        size: AdSize.banner,
      );
      myBanner.load();
      return Container(
        alignment: Alignment.center,
        width: myBanner.size.width.toDouble(),
        height: myBanner.size.height.toDouble(),
        child: AdWidget(
          ad: myBanner,
          key: Key(myBanner.hashCode.toString()),
        ),
      );
    });
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }
}
