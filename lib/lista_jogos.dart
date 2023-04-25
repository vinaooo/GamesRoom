import 'package:flutter/material.dart';

class Jogo {
  final String titulo;
  final Widget icone;

  const Jogo({required this.titulo, required this.icone});
}

final List<Jogo> jogos = [
  Jogo(titulo: 'Jogo 1', icone: Image.asset('assets/icons/tictactoe-80.png')),
  const Jogo(
      titulo: 'Jogo 2',
      icone: Icon(Icons.sports_basketball, color: Colors.red)),
  const Jogo(
      titulo: 'Jogo 3', icone: Icon(Icons.emoji_events, color: Colors.blue)),
  const Jogo(titulo: 'Jogo 4', icone: Icon(Icons.emoji_events)),
  const Jogo(titulo: 'Jogo 5', icone: Icon(Icons.emoji_events)),
  const Jogo(titulo: 'Jogo 6', icone: Icon(Icons.emoji_events)),
  const Jogo(titulo: 'Jogo 7', icone: Icon(Icons.emoji_events)),
  const Jogo(titulo: 'Jogo 8', icone: Icon(Icons.emoji_events)),
  const Jogo(titulo: 'Jogo 9', icone: Icon(Icons.emoji_events)),
  const Jogo(titulo: 'Jogo 10', icone: Icon(Icons.emoji_events)),
];
