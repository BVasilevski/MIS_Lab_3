import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/home/joke_types_grid.dart';
import '../widgets/joke_of_the_day/joke_of_the_day.dart';
import 'favorites.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> jokes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypesFromAPI();
  }

  void getJokeTypesFromAPI() {
    ApiService.getJokeTypes().then((response) {
      List<String> jokeTypes = List<String>.from(json.decode(response.body));
      print(jokeTypes);
      setState(() {
        jokes = jokeTypes;
      });
    }).catchError((error) {
      print("Error fetching joke types: $error");
    });
  }

  void fetchJokeOfTheDay() {
    ApiService.getJokeOfTheDay().then((response) {
      var data = json.decode(response.body);
      String joke = data['setup'] + "\n\n" + data['punchline'];

      // Navigate to the new screen with the joke
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JokeOfTheDayScreen(joke: joke),
        ),
      );
    }).catchError((error) {
      print("Error fetching joke of the day: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("211165",
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, color: Colors.white, size: 24))
        ],
      ),
      body: Stack(
        children: [
          // Main content wrapped in SafeArea
          SafeArea(
            child: JokeTypesGrid(jokeTypes: jokes),
          ),

          // Top-left "Joke" button
          Positioned(
            top: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: fetchJokeOfTheDay,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Click for joke of the day",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),

      // Floating action button for Favorites
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the FavoritesScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesScreen()),
          );
        },
        child: const Icon(Icons.favorite),
        backgroundColor: Colors.red,
      ),
    );
  }
}
