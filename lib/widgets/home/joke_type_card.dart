import 'package:flutter/material.dart';

import '../joke_by_type/jokes_from_type_screen.dart';

class JokeTypeCard extends StatelessWidget {
  final String type;

  const JokeTypeCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // On card tap, navigate to the new screen and pass the joke type
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JokeTypeJokesScreen(jokeType: type),
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              type,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
