import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Joke.dart';

class FavoriteJokesProvider with ChangeNotifier {
  List<Joke> _favoriteJokes = [];

  List<Joke> get favoriteJokes => _favoriteJokes;

  // Constructor: Load favorites from shared_preferences
  FavoriteJokesProvider() {
    _loadFavoriteJokes();
  }

  // Method to load the saved favorite jokes from shared_preferences
  Future<void> _loadFavoriteJokes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoriteJokesString = prefs.getString('favorite_jokes');

    if (favoriteJokesString != null) {
      final List<dynamic> decodedList = json.decode(favoriteJokesString);
      _favoriteJokes =
          decodedList.map((jokeData) => Joke.fromJson(jokeData)).toList();
    }
    notifyListeners(); // Notify listeners after loading the data
  }

  // Method to save the favorite jokes to shared_preferences
  Future<void> _saveFavoriteJokes() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList =
        json.encode(_favoriteJokes.map((joke) => joke.toJson()).toList());
    prefs.setString('favorite_jokes', encodedList);
  }

  bool isFavorite(Joke joke) {
    return _favoriteJokes.any((favoriteJoke) => favoriteJoke.id == joke.id);
  }

  // Method to add a joke to favorites
  void addFavoriteJoke(Joke joke) {
    _favoriteJokes.add(joke);
    _saveFavoriteJokes(); // Save to shared_preferences
    notifyListeners(); // Notify listeners
  }

  // Method to remove a joke from favorites
  void removeFavoriteJoke(Joke joke) {
    _favoriteJokes.removeWhere((favoriteJoke) => favoriteJoke.id == joke.id);
    _saveFavoriteJokes(); // Save to shared_preferences
    notifyListeners(); // Notify listeners
  }
}
