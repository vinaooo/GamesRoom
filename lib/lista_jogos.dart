// <a target="_blank" href="https://icons8.com/icon/VL53FP6Gk195/tic-tac-toe">Tic Tac Toe
//</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>

//<a href="https://www.flaticon.com/free-icons/hangman"
// title="hangman icons">Hangman icons created by Freepik - Flaticon</a>

import 'package:flutter/material.dart';

class Jogo {
  final String titulo;
  final IconData icone;

  const Jogo({required this.titulo, required this.icone});
}

const List<Jogo> jogos = [
  Jogo(titulo: 'Tic Tac Toe', icone: Icons.sports_basketball),
  Jogo(titulo: 'Jogo 2', icone: Icons.sports_basketball),
  Jogo(titulo: 'Jogo 3', icone: Icons.emoji_events),
  Jogo(titulo: 'Jogo 4', icone: Icons.gamepad),
  Jogo(titulo: 'Jogo 5', icone: Icons.sports_basketball),
  Jogo(titulo: 'Jogo 6', icone: Icons.emoji_events),
  Jogo(titulo: 'Jogo 7', icone: Icons.gamepad),
  Jogo(titulo: 'Jogo 8', icone: Icons.sports_basketball),
  Jogo(titulo: 'Jogo 9', icone: Icons.emoji_events),
];
