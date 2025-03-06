import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/features/recipe/domain/entity/ingredient_entity.dart';
import 'package:kitchening/features/recipe/presentation/view_model/single_recipe_cubit/cubit/single_recipe_cubit.dart';

class RecipeIngredients extends StatefulWidget {
  final bool? isEditable;

  const RecipeIngredients({super.key, this.isEditable});

  @override
  State<RecipeIngredients> createState() => _RecipeIngredientsState();
}

class _RecipeIngredientsState extends State<RecipeIngredients> {
  final Map<int, TextEditingController> _ingredientControllers = {};
  final Map<int, TextEditingController> _quantityControllers = {};
  final Map<int, TextEditingController> _measurementControllers = {};

  @override
  void dispose() {
    for (var controller in [
      ..._ingredientControllers.values,
      ..._quantityControllers.values,
      ..._measurementControllers.values,
    ]) {
      controller.dispose();
    }
    _ingredientControllers.clear();
    _quantityControllers.clear();
    _measurementControllers.clear();
    super.dispose();
  }

  TextEditingController _getController(
      Map<int, TextEditingController> map, int index, String text) {
    if (!map.containsKey(index)) {
      map[index] = TextEditingController(text: text);
    } else {
      map[index]!.text = text;
    }
    return map[index]!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleRecipeCubit, SingleRecipeState>(
      buildWhen: (previous, current) =>
          previous.ingredients != current.ingredients,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = state.ingredients[index];

                  final ingredientController = _getController(
                      _ingredientControllers, index, ingredient.ingredient);
                  final quantityController = _getController(
                      _quantityControllers,
                      index,
                      ingredient.quantity.toString());
                  final measurementController = _getController(
                      _measurementControllers, index, ingredient.measurement);

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
                            controller: ingredientController,
                            onChanged: widget.isEditable == true
                                ? (value) {
                                    context
                                        .read<SingleRecipeCubit>()
                                        .updateIngredient(
                                          index,
                                          value,
                                          ingredient.quantity,
                                          ingredient.measurement,
                                        );
                                  }
                                : null,
                            readOnly: widget.isEditable == false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Quantity",
                              filled: true,
                            ),
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            onChanged: widget.isEditable == true
                                ? (value) {
                                    context
                                        .read<SingleRecipeCubit>()
                                        .updateIngredient(
                                          index,
                                          ingredient.ingredient,
                                          double.tryParse(value) ?? 0.0,
                                          ingredient.measurement,
                                        );
                                  }
                                : null,
                            readOnly: widget.isEditable == false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Measurement",
                              filled: true,
                            ),
                            controller: measurementController,
                            onChanged: widget.isEditable == true
                                ? (value) {
                                    context
                                        .read<SingleRecipeCubit>()
                                        .updateIngredient(
                                          index,
                                          ingredient.ingredient,
                                          ingredient.quantity,
                                          value,
                                        );
                                  }
                                : null,
                            readOnly: widget.isEditable == false,
                          ),
                        ),
                        if (widget.isEditable == true)
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              context
                                  .read<SingleRecipeCubit>()
                                  .removeIngredient(index);
                              setState(() {
                                _ingredientControllers.remove(index);
                                _quantityControllers.remove(index);
                                _measurementControllers.remove(index);
                              });
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (widget.isEditable == true)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<SingleRecipeCubit>().addIngredient(
                          const IngredientEntity(
                              ingredient: "", quantity: 0.0, measurement: ""),
                        );
                    setState(() {
                      int newIndex = state.ingredients.length;
                      _ingredientControllers[newIndex] =
                          TextEditingController();
                      _quantityControllers[newIndex] = TextEditingController();
                      _measurementControllers[newIndex] =
                          TextEditingController();
                    });
                  },
                  child: const Text("Add"),
                ),
              ),
          ],
        );
      },
    );
  }
}
