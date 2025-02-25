import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kitchening/app/common/gap.dart';
import 'package:kitchening/app/common/styles.dart';
import 'package:kitchening/features/recipe/presentation/view/common/recipe_ingredients.dart';
import 'package:kitchening/features/recipe/presentation/view/common/recipe_steps.dart';

class CreateRecipeScreenView extends StatefulWidget {
  const CreateRecipeScreenView({super.key});

  @override
  State<CreateRecipeScreenView> createState() => _CreateRecipeScreenViewState();
}

class _CreateRecipeScreenViewState extends State<CreateRecipeScreenView> {
  File? _img;
  final List<Map<String, String>> _ingredients = [
    {"ingredient": "salt", "quantity": "2 tablespoon"},
  ];
  final List<String> _steps = [
    "Take 1 teaspoon of salt",
  ];

  void _addIngredient() {
    setState(() {
      _ingredients.add({"ingredient": "", "quantity": ""});
    });
  }

  void _addStep() {
    setState(() {
      _steps.add("");
    });
  }

  @override
  Widget build(BuildContext context) {
    const tabBar = TabBar(
      labelPadding: EdgeInsets.symmetric(vertical: 6),
      tabs: [
        Text("Picture"),
        Text("Ingredients"),
        Text("Steps"),
      ],
      indicatorColor: Colors.white,
      labelColor: Colors.white,
    );
    return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Column(
          children: [
            const ColoredBox(
              color: caribeanCurrent,
              child: tabBar,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  const TextField(
                      decoration: InputDecoration(label: Text("Recipe Name"))),
                  Row(
                    children: [
                      const Text("Is this recipe public?"),
                      Checkbox(value: true, onChanged: (value) {}),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: TabBarView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(24.0),
                    child: Image(
                      image: _img != null
                          ? FileImage(_img!)
                          : const AssetImage('assets/images/profile.png')
                              as ImageProvider,
                    ),
                  ),
                  RecipeIngredients(
                    ingredients: _ingredients,
                    onAddIngredient: _addIngredient,
                  ),
                  RecipeSteps(
                    steps: _steps,
                    onAddStep: _addStep,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text("Create")),
            ),
            gap8Y,
          ],
        ));
  }
}
