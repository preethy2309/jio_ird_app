import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/state_provider.dart'; // import your provider file
import 'cart_item_tile.dart';

class CartItemsList extends ConsumerWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemQuantitiesProvider);

    if (items.isEmpty) {
      return const Center(
        child: Text(
          "Cart is empty",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final dishWithQty = items[index];
        final dish = dishWithQty.dish;

        void increment() {
          final currentList = [...items];
          currentList[index].quantity++;
          ref.read(itemQuantitiesProvider.notifier).state = currentList;
        }

        void decrement() {
          final currentList = [...items];
          final newQty = currentList[index].quantity - 1;
          if (newQty <= 0) {
            currentList.removeAt(index);
          } else {
            currentList[index].quantity = newQty;
          }
          ref.read(itemQuantitiesProvider.notifier).state = currentList;
        }

        return CartItemTile(
          title: dish.name ?? "Unknown",
          quantity: dishWithQty.quantity,
          price: dish.dish_price,
          type: dish.dish_type,
          onIncrement: increment,
          onDecrement: decrement,
        );
      },
    );
  }
}
