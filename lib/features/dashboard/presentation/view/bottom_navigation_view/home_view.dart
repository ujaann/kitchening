import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/common/my_card.dart';
import 'package:kitchening/app/common/styles.dart';
import 'package:kitchening/features/recipe/presentation/view/recipe_detail_view.dart';
import 'package:kitchening/features/recipe/presentation/view_model/all_recipe_bloc/recipe_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Search \n for recipes",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Recipe name",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            scrollDirection: Axis.horizontal,
            child: Container(
              color: papayaWhip,
              child: Row(
                spacing: 24,
                children: [
                  IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: papayaWhip,
                      ),
                      onPressed: () {},
                      iconSize: 40,
                      icon: const Column(
                        children: [
                          Icon(Icons.food_bank),
                          Text(
                            "Thai",
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      )),
                  IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: papayaWhip,
                      ),
                      onPressed: () {},
                      iconSize: 40,
                      icon: const Column(
                        children: [
                          Icon(Icons.food_bank),
                          Text(
                            "Thai",
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      )),
                  IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: papayaWhip,
                      ),
                      onPressed: () {},
                      iconSize: 40,
                      icon: const Column(
                        children: [
                          Icon(Icons.food_bank),
                          Text(
                            "Thai",
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Trending",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                BlocBuilder<RecipeBloc, RecipeState>(
                  builder: (context, state) {
                    if (state is RecipeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RecipeSuccess) {
                      return Row(
                        children: state.recipes.map((recipe) {
                          return SmallRecipeCard(
                            onIconPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetailView(recipeEntity: recipe),
                                ),
                              );
                            },
                            recipeEntity: recipe,
                            // Add other properties as needed
                          );
                        }).toList(),
                      );
                    } else if (state is RecipeError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text('No recipes found.'));
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
