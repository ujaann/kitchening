import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/core/constants/api_endpoints.dart';
import 'package:kitchening/features/recipe/domain/entity/recipe_entity.dart';
import 'package:kitchening/features/recipe/presentation/view/common/recipe_ingredients.dart';
import 'package:kitchening/features/recipe/presentation/view/common/recipe_steps.dart';
import 'package:kitchening/features/recipe/presentation/view_model/all_recipe_bloc/recipe_bloc.dart';
import 'package:kitchening/features/recipe/presentation/view_model/single_recipe_cubit/cubit/single_recipe_cubit.dart';

class RecipeDetailView extends StatefulWidget {
  final RecipeEntity recipeEntity;

  const RecipeDetailView({
    super.key,
    required this.recipeEntity,
  });

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  @override
  Widget build(BuildContext context) {
    final recipCubit = SingleRecipeCubit(
        recipeState: SingleRecipeState(
            ingredients: widget.recipeEntity.ingredients,
            steps: widget.recipeEntity.steps));

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.recipeEntity.recipeName),
          actions: [
            BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () => context.read<RecipeBloc>().add(
                      LikeRecipeEvent(
                          recipeId: widget.recipeEntity.recipeId ?? "")),
                  icon: Icon(state is RecipeSuccess
                      ? Icons.favorite
                      : Icons.favorite_outline),
                );
              },
            ),
            Text(widget.recipeEntity.cuisine),
          ],
          bottom: const TabBar(
            labelPadding: EdgeInsets.symmetric(vertical: 6),
            labelStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 1),
            tabs: [
              Text("Picture"),
              Text("Ingredients"),
              Text("Steps"),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xffC0D2C2),
          ),
        ),
        body: Flexible(
          child: TabBarView(
            children: [
              Container(
                  margin: const EdgeInsets.all(24.0),
                  child: widget.recipeEntity.imageName != null
                      ? Image.network(
                          "${ApiEndpoints.baseUrl}${ApiEndpoints.recipeImage}${widget.recipeEntity.imageName}")
                      : Image.asset("assets/images/logo.png")),
              BlocProvider<SingleRecipeCubit>.value(
                value: recipCubit,
                child: const RecipeIngredients(isEditable: false),
              ),
              BlocProvider<SingleRecipeCubit>.value(
                value: recipCubit,
                child: const RecipeSteps(isEditable: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
