import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/features/recipe/domain/entity/ingredient_entity.dart';
import 'package:kitchening/features/recipe/presentation/view_model/single_recipe_cubit/cubit/single_recipe_cubit.dart';

class RecipeIngredients extends StatelessWidget {
  final bool? isEditable;

  const RecipeIngredients({super.key, this.isEditable});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: BlocBuilder<SingleRecipeCubit, SingleRecipeState>(
            builder: (context, state) {
              print(state.ingredients);
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.ingredients.length,
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
                              text: state.ingredients[index].ingredient,
                            ),
                            onChanged: isEditable == true
                                ? (value) {
                                    context
                                        .read<SingleRecipeCubit>()
                                        .updateIngredient(
                                            index,
                                            value,
                                            state.ingredients[index].quantity,
                                            state.ingredients[index]
                                                .measurement);
                                  }
                                : null,
                            readOnly: isEditable == false,
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
                              text:
                                  state.ingredients[index].quantity.toString(),
                            ),
                            onChanged: isEditable == true
                                ? (value) {
                                    context
                                        .read<SingleRecipeCubit>()
                                        .updateIngredient(
                                            index,
                                            state.ingredients[index].ingredient,
                                            double.tryParse(value) ?? 0.0,
                                            state.ingredients[index]
                                                .measurement);
                                  }
                                : null,
                            readOnly: isEditable == false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Measurement",
                              filled: true,
                            ),
                            controller: TextEditingController(
                              text: state.ingredients[index].measurement,
                            ),
                            onChanged: isEditable == true
                                ? (value) {
                                    context
                                        .read<SingleRecipeCubit>()
                                        .updateIngredient(
                                            index,
                                            state.ingredients[index].ingredient,
                                            state.ingredients[index].quantity,
                                            value);
                                  }
                                : null,
                            readOnly: isEditable == false,
                          ),
                        ),
                        if (isEditable == true)
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => context
                                .read<SingleRecipeCubit>()
                                .removeIngredient(index),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        if (isEditable == true)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<SingleRecipeCubit>().addIngredient(
                      const IngredientEntity(
                          ingredient: "", quantity: 0.0, measurement: ""),
                    );
              },
              child: const Text("Add"),
            ),
          ),
      ],
    );
  }
}
