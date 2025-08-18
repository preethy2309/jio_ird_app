import 'package:flutter/material.dart';
import '../quantity_selector.dart';

class CartItemTile extends StatelessWidget {
  final String title;
  final int quantity;
  final String price;
  final String type;

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  final FocusNode plusFocusNode;
  final FocusNode minusFocusNode;

  const CartItemTile({
    super.key,
    required this.title,
    required this.quantity,
    required this.price,
    this.type = "veg",
    required this.onIncrement,
    required this.onDecrement,
    required this.plusFocusNode,
    required this.minusFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    final Color dotColor = type.toLowerCase() == "veg" ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
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
              // Title
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 60), // Space for QuantitySelector
              // Price
              Text(
                "₹$price",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          QuantitySelector(
            quantity: quantity,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
            plusButtonFocusNode: plusFocusNode,
            minusButtonFocusNode: minusFocusNode,
          ),
        ],
      ),
    );
  }
}
