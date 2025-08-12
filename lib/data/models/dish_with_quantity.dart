import 'dish_model.dart';

class DishWithQuantity {
  final Dish dish;
  int quantity;

  DishWithQuantity({required this.dish, this.quantity = 1});
}
