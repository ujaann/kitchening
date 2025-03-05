import 'package:flutter/material.dart';
import 'package:kitchening/app/common/my_card.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Liked recipes", style: TextStyle(fontSize: 20)),
          Flexible(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => const RecipeCard(),
            ),
          ),
        ],
      ),
    );
  }
}
