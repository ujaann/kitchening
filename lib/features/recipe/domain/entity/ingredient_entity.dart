import 'package:equatable/equatable.dart';

class IngredientEntity extends Equatable {
  final String ingredient;
  final double quantity;
  final String measurement;

  const IngredientEntity({
    required this.ingredient,
    required this.quantity,
    required this.measurement,
  });

  @override
  List<Object> get props => [ingredient, measurement];

  IngredientEntity copyWith({
    String? ingredient,
    double? quantity,
    String? measurement,
  }) {
    return IngredientEntity(
      ingredient: ingredient ?? this.ingredient,
      quantity: quantity ?? this.quantity,
      measurement: measurement ?? this.measurement,
    );
  }
}
