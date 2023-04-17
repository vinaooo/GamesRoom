// ignore_for_file: unused_field

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'tictactoe2p.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

Future<void> main() async {
  runApp(
    const GameRoomApp(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class GameRoomApp extends StatelessWidget {
  const GameRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            brightness: const ColorScheme.light().brightness,
            colorScheme: lightDynamic),
        home: const PaginaInicial(),
      );
    });
  }
}

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  BannerAd? bannerAd;
  final String _adUnitId = 'ca-app-pub-4860380403931913/4313648864';

  static const _kFontFam = 'iconFonts';
  static const String? _kFontPkg = null;

  static const IconData emoHappy =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoWink =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoUnhappy =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoSleep =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoThumbsup =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoDevil =
      IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoSurprised =
      IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoTongue =
      IconData(0xe807, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoCoffee =
      IconData(0xe808, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoSunglasses =
      IconData(0xe809, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoDispleased =
      IconData(0xe80a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData dribble =
      IconData(0xe80b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoGrin =
      IconData(0xe80c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoAngry =
      IconData(0xe80d, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoSaint =
      IconData(0xe80e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoCry =
      IconData(0xe80f, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData smiley =
      IconData(0xe810, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoSquint =
      IconData(0xe811, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoLaugh =
      IconData(0xe812, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData emoWink2 =
      IconData(0xe813, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData giraffe =
      IconData(0xe81b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData school =
      IconData(0xe834, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData soccer =
      IconData(0xe837, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData crown =
      IconData(0xe844, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData crownPlus =
      IconData(0xe845, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData crownMinus =
      IconData(0xe846, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData acorn =
      IconData(0xe901, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData carrot =
      IconData(0xe95c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData cheese =
      IconData(0xe961, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData chickenLeg =
      IconData(0xe964, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData crabClaw =
      IconData(0xe974, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData falling =
      IconData(0xe9b9, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData footprint =
      IconData(0xe9d2, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData gecko =
      IconData(0xe9de, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData monsterSkull =
      IconData(0xea43, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData rabbit =
      IconData(0xea76, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData skull =
      IconData(0xeaa1, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData soccerBall =
      IconData(0xeaa8, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData user =
      IconData(0xf007, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData smile =
      IconData(0xf118, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData frown =
      IconData(0xf119, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData meh =
      IconData(0xf11a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData female =
      IconData(0xf182, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData male =
      IconData(0xf183, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData child =
      IconData(0xf1ae, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData userSecret =
      IconData(0xf21b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData squirrel =
      IconData(0xf347, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData ruby =
      IconData(0xf3c9, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  IconData selectedIcon = Icons.person;

  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    //themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark
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

  String player1Name = '';
  String player2Name = '';

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
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
          home: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Game Room',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.9,
                ),
              ),
              centerTitle: true,
            ),
            body: FutureBuilder(
              future: _initGoogleMobileAds(),
              builder: (context, AsyncSnapshot<void> snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: SizedBox(
                          child: Platform.isAndroid == true
                              ? bannerAds(context)
                              : null,
                        ),
                      ),
                      Center(
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      icon: const Icon(
                                        emoHappy,
                                        size: 100,
                                        weight: 400,
                                      ),
                                      title: const Text("Enter players name:"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 4, 0, 4),
                                            child: TextField(
                                              onChanged: (value) {
                                                player1Name = value;
                                              },
                                              decoration: InputDecoration(
                                                prefixIcon: Align(
                                                  widthFactor: 1.0,
                                                  heightFactor: 1.0,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            IconPickerDialog(
                                                          icons: const [
                                                            emoHappy,
                                                            emoWink,
                                                            emoUnhappy,
                                                            emoSleep,
                                                            emoThumbsup,
                                                            emoDevil,
                                                            emoSurprised,
                                                            emoTongue,
                                                            emoCoffee,
                                                            emoSunglasses,
                                                            emoDispleased,
                                                            emoGrin,
                                                            emoAngry,
                                                            emoSaint,
                                                            emoCry,
                                                            emoSquint,
                                                            emoLaugh,
                                                            emoWink2,
                                                            smiley,
                                                            user,
                                                            smile,
                                                            frown,
                                                            meh,
                                                            female,
                                                            male,
                                                            child,
                                                            school,
                                                            falling,
                                                            skull,
                                                            monsterSkull,
                                                            userSecret,
                                                            soccerBall,
                                                            soccer,
                                                            dribble,
                                                            giraffe,
                                                            crown,
                                                            crownPlus,
                                                            crownMinus,
                                                            acorn,
                                                            carrot,
                                                            cheese,
                                                            chickenLeg,
                                                            crabClaw,
                                                            footprint,
                                                            gecko,
                                                            rabbit,
                                                            squirrel,
                                                            ruby,
                                                          ],
                                                          onIconSelected:
                                                              (icon) {
                                                            setState(() {
                                                              selectedIcon =
                                                                  icon; // <-- Atualiza o ícone selecionado
                                                            });
                                                          },
                                                        ),
                                                      ).then((value) {
                                                        if (value != null) {
                                                          setState(() {
                                                            selectedIcon =
                                                                value;
                                                          });
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(
                                                      selectedIcon ??
                                                          Icons.person,
                                                    ),
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(4),
                                                border:
                                                    const OutlineInputBorder(),
                                                labelText: "Player 1",
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 4, 0, 4),
                                            child: TextField(
                                              onChanged: (value) {
                                                player2Name = value;
                                              },
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(4),
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
                                                    player2Name: player2Name,
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
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      child: Stack(
                                        children: [
                                          Stack(
                                            children: [
                                              const Stack(
                                                children: [
                                                  Icon(
                                                    Icons.tag_rounded,
                                                    weight: 1,
                                                    size: 140,
                                                  ),
                                                  Positioned(
                                                    bottom: 22,
                                                    right: 22,
                                                    child: Icon(
                                                      Icons.circle_outlined,
                                                      color: Colors.green,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Positioned(
                                                top: 22,
                                                left: 22,
                                                child: Icon(
                                                  Icons.close,
                                                  color:
                                                      const ColorScheme.light()
                                                          .error,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Positioned(
                                            bottom: 0,
                                            left: 28,
                                            child: Text('TicTacToe'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Placeholder();
                                    },
                                  ),
                                );
                              },
                              child: const Card(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Placeholder();
                                    },
                                  ),
                                );
                              },
                              child: const Card(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Placeholder();
                                    },
                                  ),
                                );
                              },
                              child: const Card(),
                            ),
                            const Card(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Placeholder();
                                    },
                                  ),
                                );
                              },
                              child: const Card(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
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

class IconPickerDialog extends StatefulWidget {
  final List<IconData> icons;
  final void Function(IconData selectedIcon) onIconSelected;

  const IconPickerDialog({
    Key? key,
    required this.icons,
    required this.onIconSelected,
  }) : super(key: key);

  @override
  _IconPickerDialogState createState() => _IconPickerDialogState();
}

class _IconPickerDialogState extends State<IconPickerDialog> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.count(
          crossAxisCount: 6,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          shrinkWrap: true,
          children: widget.icons
              .map(
                (iconData) => InkWell(
                  onTap: () {
                    Navigator.of(context).pop(iconData);
                  },
                  child: Icon(
                    iconData,
                    size: 24,
                    color: selectedIcon == iconData
                        ? Theme.of(context).primaryColorDark
                        : null,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
