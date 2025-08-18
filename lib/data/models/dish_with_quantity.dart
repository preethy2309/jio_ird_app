import 'package:jio_ird/data/models/dish_model.dart';

class DishWithQuantity {
  final Dish dish;
  final int quantity;

  DishWithQuantity({required this.dish, required this.quantity});

  DishWithQuantity copyWith({Dish? dish, int? quantity}) {
    return DishWithQuantity(
      dish: dish ?? this.dish,
      quantity: quantity ?? this.quantity,
    );
  }

  factory DishWithQuantity.fromJson(Map<String, dynamic> json) {
    return DishWithQuantity(
      dish: Dish.fromJson(json['dish']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dish': dish.toJson(),
      'quantity': quantity,
    };
  }
}
