import 'package:flutter/material.dart';
import 'joke_type_card.dart';

class JokeTypesGrid extends StatelessWidget {
  final List<String> jokeTypes;

  const JokeTypesGrid({super.key, required this.jokeTypes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = (constraints.maxWidth / 150).floor();
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount > 0
                  ? crossAxisCount
                  : 1, // Ensure at least 1 column
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1, // Square grid items
            ),
            itemCount: jokeTypes.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return JokeTypeCard(type: jokeTypes[index]);
            },
          );
        },
      ),
    );
  }
}