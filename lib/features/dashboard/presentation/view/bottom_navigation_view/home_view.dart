import 'package:flutter/material.dart';
import 'package:kitchening/common/my_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Recommended Recipes",
              style: TextStyle(fontSize: 20),
            ),
          ),
          RecipeCard(),
          RecipeCard(),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Recently Cooked",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SmallRecipeCard(),
                SmallRecipeCard(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
