import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'tictactoe2p.dart';
import 'tictactoesp.dart';
import 'ad_helper.dart';

void main() {
  runApp(
    const GameRoomApp(),
  );
  WidgetsFlutterBinding.ensureInitialized();
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
        title: 'Game Room',
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
          if (kDebugMode) {
            print(
                'Ad load failed (code=${error.code} message=${error.message})');
          }
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
                        SizedBox(
                          child: bannerAds(context),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const TicTacToe2PPage();
                                      },
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 6,
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
                                                      Icons.tag_sharp,
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
                                                    color: const ColorScheme
                                                            .light()
                                                        .error,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Positioned(
                                              bottom: 0,
                                              left: 28,
                                              child: Text('2 Players'),
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
                                        return const TicTacToePage();
                                      },
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 6,
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
                                                    FittedBox(
                                                      child: Icon(
                                                        Icons.tag_sharp,
                                                        size: 140,
                                                      ),
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
                                                    color: const ColorScheme
                                                            .light()
                                                        .error,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Positioned(
                                              bottom: 0,
                                              left: 28,
                                              child: Text('Single Player'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
