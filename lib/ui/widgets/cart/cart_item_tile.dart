import 'package:flutter/material.dart';

import '../quantity_selector.dart';

class CartItemTile extends StatelessWidget {
  final String title;
  final int quantity;
  final String price;
  final String type; // "veg" or "non-veg"

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemTile({
    super.key,
    required this.title,
    required this.quantity,
    required this.price,
    this.type = "veg",
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final Color dotColor =
        type.toLowerCase() == "veg" ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: dotColor, width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const Spacer(),

          QuantitySelector(
            quantity: quantity,
            onIncrement: onIncrement,
            onDecrement:onDecrement,
          ),

          const SizedBox(width: 12),

          const Spacer(),
          // Price
          Text(
            "₹$price",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
