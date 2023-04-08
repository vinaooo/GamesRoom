// ignore_for_file: avoid_print

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';

class TicTacToe2PPage extends StatefulWidget {
  const TicTacToe2PPage({super.key});

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
      message = 'Player 1 Wins!';
      icon = Icons.mood;
      color = Colors.green;
    } else if (winner == 'O') {
      message = 'Player 2 Wins!';
      icon = Icons.mood_bad;
      color = const ColorScheme.dark().errorContainer;
    } else {
      message = 'It\'s a Tie!';
      icon = Icons.sentiment_neutral;
      color = Colors.yellow;
    }

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: color,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 50.0),
                const SizedBox(height: 10.0),
                Text(message, style: const TextStyle(fontSize: 24.0)),
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

  Widget _buildBox(int row, int col) {
    return GestureDetector(
      onTap: () => _markBox(row, col),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightForFinite(width: 300),
        child: SizedBox(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1,
              child: ColoredBox(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    board[row][col],
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  BannerAd? bannerAd;
  @override
  void initState() {
    super.initState();

    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          theme: ThemeData(
            brightness: const ColorScheme.light().brightness,
            useMaterial3: true,
          ),
          home: Scaffold(
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
                      SizedBox(
                        child: bannerAds(context),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  _buildBox(0, 0),
                                  _buildBox(0, 1),
                                  _buildBox(0, 2),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  _buildBox(1, 0),
                                  _buildBox(1, 1),
                                  _buildBox(1, 2),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  _buildBox(2, 0),
                                  _buildBox(2, 1),
                                  _buildBox(2, 2),
                                ],
                              ),
                              const SizedBox(height: 24.0),
                              ElevatedButton(
                                onPressed: _resetBoard,
                                child: const Text('Reset'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        );
      },
    );
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
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
}
