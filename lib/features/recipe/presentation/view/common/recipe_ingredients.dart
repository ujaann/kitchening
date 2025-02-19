import 'package:flutter/material.dart';

class RecipeIngredients extends StatelessWidget {
  const RecipeIngredients({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Ingredient")),
        DataColumn(label: Text("Quantity")),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(TextField()),
          DataCell(TextField()),
        ]),
        DataRow(cells: [
          DataCell(Text("Ingredient 1")),
          DataCell(Text("Quantity 1")),
        ]),
      ],
    );
  }
}
