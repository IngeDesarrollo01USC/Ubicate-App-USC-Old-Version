import 'package:flutter/material.dart';

final _colors = <String, Color>{
  'amber': Colors.amber,
  'black': Colors.black,
  'blue': Colors.blue,
  'blueGrey': Colors.blueGrey,
  'brown': Colors.brown,
  'ciencias-basicas': const Color.fromRGBO(3, 155, 146, 1),
  'ciencias-economicas': const Color.fromRGBO(0, 150, 63, 1),
  'comunicacion': const Color.fromRGBO(227, 0, 15, 1),
  'cyan': Colors.cyan,
  'deepOrange': Colors.deepOrange,
  'deepPurple': Colors.deepPurple,
  'derecho': const Color.fromRGBO(90, 81, 158, 1),
  'educacion': const Color.fromRGBO(252, 190, 0, 1),
  'extension': const Color.fromRGBO(35, 65, 132, 1),
  'green': Colors.green,
  'grey': Colors.grey,
  'indigo': Colors.indigo,
  'ingenieria': const Color.fromRGBO(251, 140, 0, 1),
  'institutional': const Color.fromRGBO(35, 65, 132, 1),
  'lightBlue': Colors.lightBlue,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'purple': Colors.purple,
  'red': Colors.red,
  'salud': const Color.fromRGBO(64, 130, 193, 1),
  'sand': const Color.fromRGBO(194, 168, 128, 1),
  'teal': Colors.teal,
  'white': Colors.white,
  'yellow': Colors.yellow,
};

Color? getColor(String colorName) {
  return _colors[colorName];
}
