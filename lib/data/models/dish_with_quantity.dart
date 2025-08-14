class DishWithQuantity {
  final dynamic dish;
  final int quantity;

  DishWithQuantity({
    required this.dish,
    required this.quantity,
  });

  DishWithQuantity copyWith({
    dynamic dish,
    int? quantity,
  }) {
    return DishWithQuantity(
      dish: dish ?? this.dish,
      quantity: quantity ?? this.quantity,
    );
  }
}
