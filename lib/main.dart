import 'package:fast_shablon_deck/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const fastShablonDesck());
}

class fastShablonDesck extends StatelessWidget {
  const fastShablonDesck({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Шаблоны для работы',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Шаблоны для работы'),
    );
  }
}

