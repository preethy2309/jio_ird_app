import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/dish_with_quantity.dart';

class CartNotifier extends StateNotifier<List<DishWithQuantity>> {
  CartNotifier() : super([]);

  void addItem(DishWithQuantity newItem) {
    // If already exists, increment quantity
    final index = state.indexWhere((item) => item.dish.id == newItem.dish.id);
    if (index != -1) {
      increment(index);
    } else {
      state = [...state, newItem];
    }
  }

  void increment(int index) {
    final updatedItem = state[index].copyWith(
      quantity: state[index].quantity + 1,
    );
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updatedItem else state[i]
    ];
  }

  void decrement(int index) {
    if (index < 0 || index >= state.length) return;

    final item = state[index];

    if (item.quantity <= 1) {
      // Remove the item
      state = [
        for (int i = 0; i < state.length; i++)
          if (i != index) state[i]
      ];
    } else {
      // Update with new quantity
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            item.copyWith(quantity: item.quantity - 1)
          else
            state[i]
      ];
    }
  }


  void clearCart() {
    state = [];
  }
}

final itemQuantitiesProvider =
StateNotifierProvider<CartNotifier, List<DishWithQuantity>>((ref) {
  return CartNotifier();
});
