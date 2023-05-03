import 'package:flutter/material.dart';
import 'my_flutter_app_icons.dart';
import 'main.dart';
import 'package:flutter/scheduler.dart';

String player1Name = 'Player1';
Icon player1Icon = const Icon(MyIcons.emoHappy);
Color player1Color = Colors.purple;
String player2Name = 'Player2';
Icon player2Icon = const Icon(MyIcons.crabClaw);
Color player2Color = Colors.pink;

ACustomColors lightCustomColors =
    const ACustomColors(danger: Color(0xFFE53935));
ACustomColors darkCustomColors = const ACustomColors(danger: Color(0xFFEF9A9A));

var brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;
bool isLightMode = brightness == Brightness.light;
