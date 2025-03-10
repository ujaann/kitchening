import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/common/my_card.dart';
import 'package:kitchening/app/service_locator/service_locator.dart';
import 'package:kitchening/features/recipe/presentation/view/recipe_detail_view.dart';
import 'package:kitchening/features/recipe/presentation/view_model/all_recipe_bloc/recipe_bloc.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeBloc>().add(GetUserAllRecipeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Library", style: TextStyle(fontSize: 20)),
          Flexible(
            child: BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, state) {
                if (state is RecipeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RecipeError) {
                  return Center(child: Text(state.message));
                } else if (state is RecipeSuccess) {
                  return ListView.builder(
                    itemCount: state.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = state.recipes[index];
                      return RecipeCard(
                        recipeEntity: recipe,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<RecipeBloc>.value(
                                value: getIt<RecipeBloc>(),
                                child: RecipeDetailView(recipeEntity: recipe),
                              ),
                            )),
                      );
                    },
                  );
                }
                return const Center(child: Text("No recipes found in library"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
