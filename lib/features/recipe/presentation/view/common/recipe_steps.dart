import 'package:flutter/material.dart';

class RecipeSteps extends StatelessWidget {
  const RecipeSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          Step(
            count: 1,
            description: "Step 1",
          ),
          Step(
            count: 2,
            description: "Step 2",
          ),
        ],
      ),
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
        const Expanded(
            child: TextField(
          decoration: InputDecoration(hintText: "Description"),
          style: TextStyle(fontSize: 16),
        )),
      ],
    );
  }
}
