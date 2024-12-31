import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Joke.dart';
import '../../provider/FavoriteJokeProvider.dart';
import '../../screens/favorites.dart';
import '../../services/api_service.dart';

class JokeTypeJokesScreen extends StatefulWidget {
  final String jokeType;

  const JokeTypeJokesScreen({super.key, required this.jokeType});

  @override
  State<JokeTypeJokesScreen> createState() => _JokeTypeJokesScreenState();
}

class _JokeTypeJokesScreenState extends State<JokeTypeJokesScreen> {
  List<Joke> jokes = [];

  @override
  void initState() {
    super.initState();
    fetchJokesOfType(widget.jokeType);
  }

  void fetchJokesOfType(String type) async {
    try {
      List<Map<String, dynamic>> fetchedJokes =
      await ApiService.getJokesByType(type);

      // Convert Map<String, dynamic> to Joke objects
      setState(() {
        jokes = fetchedJokes
            .map((jokeData) => Joke.fromJson(jokeData))
            .toList();
      });
    } catch (error) {
      print("Error fetching jokes of type $type: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes of type: ${widget.jokeType}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: jokes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          var joke = jokes[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(joke.setup),
              subtitle: Text(joke.punchline),
              trailing: IconButton(
                icon: Icon(
                  context.watch<FavoriteJokesProvider>().isFavorite(joke)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  if (context.read<FavoriteJokesProvider>().isFavorite(joke)) {
                    context.read<FavoriteJokesProvider>().removeFavoriteJoke(joke);
                  } else {
                    context.read<FavoriteJokesProvider>().addFavoriteJoke(joke);
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the FavoritesScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesScreen()),
          );
        },
        child: Icon(Icons.favorite),
        backgroundColor: Colors.red,
      ),
    );
  }
}
