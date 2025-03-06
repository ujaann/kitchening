import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/common/gap.dart';
import 'package:kitchening/features/recipe/presentation/view_model/single_recipe_cubit/cubit/single_recipe_cubit.dart';

class RecipeSteps extends StatefulWidget {
  final bool? isEditable;

  const RecipeSteps({super.key, this.isEditable});

  @override
  State<RecipeSteps> createState() => _RecipeStepsState();
}

class _RecipeStepsState extends State<RecipeSteps> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    super.dispose();
  }

  TextEditingController _getController(int index, String text) {
    if (!_controllers.containsKey(index)) {
      _controllers[index] = TextEditingController(text: text);
    } else {
      _controllers[index]!.text = text;
    }
    return _controllers[index]!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleRecipeCubit, SingleRecipeState>(
      buildWhen: (previous, current) => previous.steps != current.steps,
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
                  final controller = _getController(index, state.steps[index]);
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: StepWidget(
                      count: index + 1,
                      controller: controller,
                      onChanged: (value) {
                        context
                            .read<SingleRecipeCubit>()
                            .updateStep(index, value);
                      },
                      onRemove: widget.isEditable == true
                          ? () {
                              context
                                  .read<SingleRecipeCubit>()
                                  .removeStep(index);
                              setState(() {
                                _controllers.remove(index);
                              });
                            }
                          : null,
                      isEditable: widget.isEditable,
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
                    context.read<SingleRecipeCubit>().addStep("");
                    setState(() {
                      _controllers[state.steps.length] =
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

class StepWidget extends StatelessWidget {
  const StepWidget({
    super.key,
    required this.count,
    required this.controller,
    required this.onChanged,
    required this.onRemove,
    this.isEditable,
  });

  final int count;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onRemove;
  final bool? isEditable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$count.",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            maxLines: 3,
            minLines: 1,
            decoration: const InputDecoration(hintText: "Description"),
            controller: controller,
            style: const TextStyle(fontSize: 16),
            onChanged: onChanged,
            readOnly: isEditable == false,
          ),
        ),
        if (isEditable == true)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onRemove,
          ),
      ],
    );
  }
}
