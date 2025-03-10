import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/common/my_card.dart';
import 'package:kitchening/app/service_locator/service_locator.dart';
import 'package:kitchening/features/recipe/presentation/view/recipe_detail_view.dart';
import 'package:kitchening/features/recipe/presentation/view_model/all_recipe_bloc/recipe_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String searchQuery = "";

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Recipe name",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, state) {
                if (state is RecipeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RecipeSuccess) {
                  final filteredRecipes = state.recipes.where((recipe) {
                    return recipe.recipeName
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                  }).toList();
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filteredRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return SmallRecipeCard(
                        onIconPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<RecipeBloc>.value(
                                value: getIt<RecipeBloc>(),
                                child: RecipeDetailView(recipeEntity: recipe),
                              ),
                            ),
                          );
                        },
                        recipeEntity: recipe,
                        // Add other properties as needed
                      );
                    },
                  );
                } else if (state is RecipeError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No recipes found.'));
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
