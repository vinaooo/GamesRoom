import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tictactoe/tictactoe2p.dart';
import 'my_flutter_app_icons.dart';
import 'tictactoe/icon_picker.dart';
import 'lista_jogos.dart';
import 'const.dart';
import 'about.dart';
import 'ad_helper.dart';
import 'hangman/hangman.dart';

@immutable
class ACustomColors extends ThemeExtension<ACustomColors> {
  const ACustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  ACustomColors copyWith({Color? danger}) {
    return ACustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  ACustomColors lerp(ThemeExtension<ACustomColors>? other, double t) {
    if (other is! ACustomColors) {
      return this;
    }
    return ACustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  ACustomColors harmonized(ColorScheme dynamic) {
    return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
  }
}

Future<void> main() async {
  runApp(
    const MyApp(),
  );
  MobileAds.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Color colorScheme = Colors.deepPurple;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Example',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorSchemeSeed: Colors.amber,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MainPage(
        title: 'Games Room',
        child: GameRoomPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({super.key, required this.child, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AdSize adSize = const AdSize(width: 300, height: 50);

  BannerAd? bannerAd;
  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    if (Platform.isAndroid == true) {
      BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        size: AdSize.fullBanner,
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
            debugPrint(
                'Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
      ).load();
    }
  }

  @override
  void dispose() {
    bannerAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      appBar: createAppBar(title: widget.title),
      bottomNavigationBar: Container(
        height: bannerAd == null ? 0 : bannerAd?.size.height.toDouble(),
        alignment: Alignment.center,
        child:
            bannerAd != null ? AdWidget(ad: bannerAd!) : const Text('Sem ads'),
      ),
    );
  }

  createAppBar({required title}) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
            itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text("About"),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text("Settings"),
            ),
          ];
        }, onSelected: (value) {
          if (value == 0) {
            debugPrint("About menu is selected.");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AboutDialogWidget();
            }));
          } else if (value == 1) {
            debugPrint("Settings menu is selected.");
          }
        }),
      ],
    );
  }
}

ThemeMode themeMode = ThemeMode.system;

class CustomCard extends StatelessWidget {
  final String title;

  final Function onTap;
  const CustomCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
      ),
    );
  }
}

class GameRoomPage extends StatefulWidget {
  const GameRoomPage({super.key});

  @override
  State<GameRoomPage> createState() => _GameRoomPageState();
}

class _GameRoomPageState extends State<GameRoomPage>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = List.generate(
    10,
    (index) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    ),
  );

  IconData selectedIcon = Icons.person;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _goToJogo1(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            // color: Color(corePalette?.primary.get(70) ?? 0xFFffffff),

            // lightColorScheme
            //     .primaryContainer,
            MyIcons.emoHappy,
            size: 100,
            weight: 400,
          ),
          title: const Text("Enter players name:"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: TextField(
                  onChanged: (value) {
                    player1Name = value;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: IconPicker(),
                    ),
                    contentPadding: EdgeInsets.all(4),
                    border: OutlineInputBorder(),
                    labelText: "Player 1",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: TextField(
                  onChanged: (value) {
                    player2Name = value;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: IconPicker(),
                    ),
                    contentPadding: EdgeInsets.all(4),
                    border: OutlineInputBorder(),
                    labelText: "Player 2",
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                if (player1Name == '') {
                  player1Name = 'Player 1';
                }
                if (player2Name == '') {
                  player2Name = 'Player 2';
                }
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TicTacToe2PPage(
                        player1Name: player1Name,
                        player1Icon: player1Icon,
                        player1Color: player1Color,
                        player2Name: player2Name,
                        player2Icon: player2Icon,
                        player2Color: player2Color,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _goToJogo2(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  void _goToJogo3(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const Placeholder();
    // }));
  }

  void _goToJogo4(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const Placeholder();
    // }));
  }

  void _goToJogo5(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const Placeholder();
    // }));
  }

  void _goToJogo6(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const Placeholder();
    // }));
  }

  void _goToJogo7(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const Placeholder();
    // }));
  }

  void _goToJogo8(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const Placeholder();
    // }));
  }

  void _goToJogo9(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const Placeholder();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    int columnCount = 3;
    return GridView.count(
      physics:
          const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
      padding: EdgeInsets.all(w / 60),
      crossAxisCount: columnCount,
      children: List.generate(
        jogos.length,
        (int index) {
          final jogo = jogos[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: columnCount,
            child: ScaleAnimation(
              duration: const Duration(milliseconds: 900),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    switch (index % 10) {
                      case 0:
                        _goToJogo1(context);
                        break;
                      case 1:
                        _goToJogo2(context);
                        break;
                      case 2:
                        _goToJogo3(context);
                        break;
                      case 3:
                        _goToJogo4(context);
                        break;
                      case 4:
                        _goToJogo5(context);
                        break;
                      case 5:
                        _goToJogo6(context);
                        break;
                      case 6:
                        _goToJogo7(context);
                        break;
                      case 7:
                        _goToJogo8(context);
                        break;
                      case 8:
                        _goToJogo9(context);
                        break;
                    }
                  },
                  child: Card(
                    elevation: isLightMode ? 1 : 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (index > 0)
                          FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  // .harmonizeWith(Color(
                                  //     corePalette!
                                  //         .primary
                                  //         .get(40))),
                                  border: Border.all(
                                      width: 1,
                                      color: isLightMode
                                          ? Colors.black
                                          : Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'Em breve',
                                  style: GoogleFonts.bigShouldersStencilDisplay(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
                        if (index == 0)
                          Image.asset(
                            'assets/icons/tictactoe-80.png',
                            color: isLightMode == true
                                ? Colors.blue.harmonizeWith(Colors.amber)
                                : Colors.white.harmonizeWith(Colors.deepPurple),
                            height: MediaQuery.of(context).size.width / 9,
                          ),
                        if (index > 0)
                          Icon(
                            jogo.icone,
                            color: Colors.red,
                            size: MediaQuery.of(context).size.width / 9,
                          ),
                        if (index == 0) const SizedBox(height: 15),
                        if (index == 0)
                          FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                decoration: BoxDecoration(
                                  color: Colors.red
                                      .harmonizeWith(Colors.deepPurple),
                                  border: Border.all(
                                      width: 2,
                                      color: isLightMode
                                          ? Colors.deepPurple
                                          : Colors.white.harmonizeWith(
                                              Colors.deepPurple)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  jogo.titulo,
                                  style: GoogleFonts.bigShouldersStencilDisplay(
                                      color: Colors.white
                                          .harmonizeWith(Colors.red),
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                        if (index > 0) Text(jogo.titulo),
                        if (index > 0) const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
