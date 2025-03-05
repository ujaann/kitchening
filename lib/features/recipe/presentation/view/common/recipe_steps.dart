import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/common/gap.dart';
import 'package:kitchening/features/recipe/presentation/view_model/single_recipe_cubit/cubit/single_recipe_cubit.dart';

class RecipeSteps extends StatelessWidget {
  const RecipeSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleRecipeCubit, SingleRecipeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.steps.length,
                separatorBuilder: (context, index) => gap8Y,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Step(
                      count: index + 1,
                      description: state.steps[index],
                      onChanged: (value) {
                        context
                            .read<SingleRecipeCubit>()
                            .updateStep(index, value);
                      },
                      onRemove: () {
                        context.read<SingleRecipeCubit>().removeStep(index);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                onPressed: () => context.read<SingleRecipeCubit>().addStep(""),
                child: const Text("Add"),
              ),
            ),
          ],
        );
      },
    );
  }
}

class Step extends StatelessWidget {
  const Step({
    super.key,
    required this.count,
    required this.description,
    required this.onChanged,
    required this.onRemove,
  });
  final int count;
  final String description;
  final ValueChanged<String> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$count.",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: TextField(
          maxLines: 3,
          minLines: 1,
          decoration: const InputDecoration(hintText: "Description"),
          controller: TextEditingController(text: description),
          style: const TextStyle(fontSize: 16),
          onChanged: onChanged,
        )),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: onRemove,
        ),
      ],
    );
  }
}
