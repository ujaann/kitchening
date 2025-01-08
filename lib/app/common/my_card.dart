import 'package:flutter/material.dart';
import 'package:kitchening/app/common/gap.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
          height: 160,
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/momo.png",
                  height: 120,
                  width: 120,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Momo"),
                    Row(
                      children: [
                        Text("Difficulty:"),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate_outlined),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Rating:"),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate_outlined),
                      ],
                    ),
                    Text("Ujan Sthapit"),
                  ],
                ),
                gap8X,
              ],
            ),
          )),
    );
  }
}

class SmallRecipeCard extends StatelessWidget {
  const SmallRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
          height: 160,
          width: MediaQuery.sizeOf(context).width * 0.48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/fry_rice.png",
                    height: 120,

                    fit: BoxFit.cover,
                    // color: Colors.black,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chicken Fried Rice"),
                    Icon(Icons.favorite_outline),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
