import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/FavoriteJokeProvider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the list of favorite jokes using Provider
    final favoriteJokes =
        Provider.of<FavoriteJokesProvider>(context).favoriteJokes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
        backgroundColor: Colors.blueAccent,
      ),
      body: favoriteJokes.isEmpty
          ? Center(child: Text('No favorite jokes yet!'))
          : ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context, index) {
                var joke = favoriteJokes[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(joke.setup),
                    subtitle: Text(joke.punchline),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Remove the joke from the favorites
                        Provider.of<FavoriteJokesProvider>(context,
                                listen: false)
                            .removeFavoriteJoke(joke);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
