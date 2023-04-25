// <a target="_blank" href="https://icons8.com/icon/VL53FP6Gk195/tic-tac-toe">Tic Tac Toe
//</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>

// ignore_for_file: unused_field

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'tictactoe2p.dart';
import 'my_flutter_app_icons.dart';
import 'icon_picker.dart';
import 'lista_jogos.dart';

const _brandBlue = Color(0xFF1E88E5);
//bool _isDemoUsingDynamicColors = false;

String player1Name = 'Player1';
Icon player1Icon = const Icon(MyIcons.emoHappy);
Color player1Color = Colors.amber;
String player2Name = 'Player2';
Icon player2Icon = const Icon(MyIcons.crabClaw);
Color player2Color = Colors.amber;

CustomColors lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
CustomColors darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));

var brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;
bool isLightMode = brightness == Brightness.light;

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
  }
}

Future<void> main() async {
  runApp(
    const GameRoomApp(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

ThemeMode themeMode = ThemeMode.system;

class GameRoomApp extends StatelessWidget {
  const GameRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;
      if (lightDynamic != null && darkDynamic != null) {
        // On Android S+ devices, use the provided dynamic color scheme.
        // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
        lightColorScheme = lightDynamic.harmonized();
        // (Optional) Customize the scheme as desired. For example, one might
        // want to use a brand color to override the dynamic [ColorScheme.secondary].
        lightColorScheme = lightColorScheme.copyWith(secondary: _brandBlue);
        // (Optional) If applicable, harmonize custom colors.
        lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

        // Repeat for the dark color scheme.
        darkColorScheme = darkDynamic.harmonized();
        darkColorScheme = darkColorScheme.copyWith(secondary: _brandBlue);
        darkCustomColors = darkCustomColors.harmonized(darkColorScheme);

        //_isDemoUsingDynamicColors = true; // ignore, only for demo purposes
      } else {
        // Otherwise, use fallback schemes.
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: _brandBlue,
        );
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: _brandBlue,
          brightness: Brightness.dark,
        );
      }

      return MaterialApp(
        themeMode: themeMode,
        theme: ThemeData(
          colorScheme: lightDynamic,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkDynamic,
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        home: FutureBuilder(
            future: DynamicColorPlugin.getCorePalette(),
            builder: (context, snapshot) {
              final corePalette = snapshot.data;
              return GridView1(
                  corePalette: corePalette ??
                      CorePalette()); // passando corePalette apenas se não for nulo
            }),
      );
    });
  }
}

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

class GridView1 extends StatefulWidget {
  final CorePalette corePalette; // novo parâmetro

  const GridView1({Key? key, required this.corePalette}) : super(key: key);

  @override
  State<GridView1> createState() => _GridView1State();
}

class _GridView1State extends State<GridView1> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = List.generate(
    10,
    (index) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    ),
  );

  BannerAd? bannerAd;
  final String _adUnitId = 'ca-app-pub-4860380403931913/4313648864';

  IconData selectedIcon = Icons.person;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    if (Platform.isAndroid) {
      BannerAd(
        adUnitId: _adUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            if (mounted) {
              setState(() {
                bannerAd = ad as BannerAd;
              });
            }
          },
          onAdFailedToLoad: (ad, error) {
            // Releases an ad resource when it fails to load
            ad.dispose();
            if (kDebugMode) {
              print(
                  'Ad load failed (code=${error.code} message=${error.message})');
            }
          },
        ),
      ).load();
    }
  }

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
            //color: Color(corePalette?.primary.get(70) ?? 0xFFffffff),

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
      return const Placeholder();
    }));
  }

  void _goToJogo3(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Placeholder();
    }));
  }

  void _goToJogo4(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Placeholder();
    }));
  }

  void _goToJogo5(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Placeholder();
    }));
  }

  void _goToJogo6(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Placeholder();
    }));
  }

  void _goToJogo7(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Placeholder();
    }));
  }

  void _goToJogo8(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Placeholder();
    }));
  }

  void _goToJogo9(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Placeholder();
    }));
  }

  void _goToJogo10(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const Placeholder();
    }));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    int columnCount = 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Games Room"),
        centerTitle: true,
      ),
      body: AnimationLimiter(
        child: GridView.count(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
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
                          case 9:
                            _goToJogo10(context);
                            break;
                        }
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            jogo.icone,
                            const SizedBox(height: 10),
                            Text(jogo.titulo),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
