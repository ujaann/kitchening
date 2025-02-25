import 'package:flutter/material.dart';
import 'package:kitchening/app/common/gap.dart';

class RecipeSteps extends StatelessWidget {
  final List<String> steps;
  final VoidCallback onAddStep;

  const RecipeSteps({
    super.key,
    required this.steps,
    required this.onAddStep,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.all(8.0),
            itemCount: steps.length,
            separatorBuilder: (context, index) => gap8Y,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Step(
                  count: index + 1,
                  description: steps[index],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ElevatedButton(
            onPressed: onAddStep,
            child: const Text("Add"),
          ),
        ),
      ],
    );
  }
}

class Step extends StatelessWidget {
  const Step({
    super.key,
    required this.count,
    required this.description,
  });
  final int count;
  final String description;

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
        )),
      ],
    );
  }
}
