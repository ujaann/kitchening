import 'package:flutter/material.dart';

class RecipeIngredients extends StatelessWidget {
  final List<Map<String, String>> ingredients;
  final VoidCallback onAddIngredient;

  const RecipeIngredients({
    super.key,
    required this.ingredients,
    required this.onAddIngredient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Ingredient",
                          filled: true,
                        ),
                        controller: TextEditingController(
                          text: ingredients[index]["ingredient"],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Quantity",
                          filled: true,
                        ),
                        controller: TextEditingController(
                          text: ingredients[index]["quantity"],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ElevatedButton(
            onPressed: onAddIngredient,
            child: const Text("Add"),
          ),
        ),
      ],
    );
  }
}
