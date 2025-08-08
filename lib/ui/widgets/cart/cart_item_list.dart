import 'package:flutter/material.dart';
import 'cart_item_tile.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data — will replace with real API
    final items = List.generate(5, (i) => {
      "title": "Paneer Butter Masala",
      "quantity": 1,
      "price": 110.0,
    });

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return CartItemTile(
          title: item["title"]!.toString(),
          quantity: item["quantity"]!.toString() == "1" ? 1 : int.parse(item["quantity"]!.toString()),
          price: item["price"]!.toString() == "0.0" ? 0.0 : double.parse(item["price"]!.toString()),
        );
      },
    );
  }
}
