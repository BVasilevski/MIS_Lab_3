import 'package:flutter/material.dart';
import 'package:lab_2/provider/FavoriteJokeProvider.dart';
import 'package:lab_2/screens/home.dart';
import 'package:lab_2/widgets/joke_by_type/jokes_from_type_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteJokesProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Joke App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
