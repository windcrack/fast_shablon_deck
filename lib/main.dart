
import 'package:fast_shablon_deck/deisng/colors.dart';
import 'package:fast_shablon_deck/screens/home.dart';
import 'package:flutter/material.dart';

void main() async {

  runApp(const FastShablonDesck());
}

class FastShablonDesck extends StatelessWidget {
  const FastShablonDesck({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Шаблоны для работы',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorYellow),
        useMaterial3: true,
      ),
      home: const FastShablonHomePage(title: 'Шаблоны для работы'),
    );
  }
}

