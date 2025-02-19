import 'dart:io';

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Create a recipe"),
            bottom: const TabBar(
              labelPadding: EdgeInsets.only(bottom: 6),
              tabs: [
                Text("Picture"),
                Text("Ingredients"),
                Text("Steps"),
              ],
              indicatorColor: Colors.white,
              labelColor: Colors.white,
            ),
          ),
          body: Card(
            color: papayaWhip,
            margin: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Flexible(
                  child: TabBarView(
                    children: [
                      Image(
                        image: _img != null
                            ? FileImage(_img!)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                      const RecipeIngredients(),
                      const RecipeSteps(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Row(
                        children: [
                          const Text("Is this recipe public?"),
                          Checkbox(value: true, onChanged: (value) {}),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Create")),
                ),
              ],
            ),
          )),
    );
  }
}
