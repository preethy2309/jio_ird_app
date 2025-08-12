import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final String title;
  final int quantity;
  final String price;
  final String type; // "veg" or "non-veg"

  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const CartItemTile({
    super.key,
    required this.title,
    required this.quantity,
    required this.price,
    this.type = "veg",
    this.onIncrement,
    this.onDecrement,
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
          // Quantity controls
          // Quantity controls container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: onDecrement,
                  child: _buildQtyButton(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: onIncrement,
                  child: _buildQtyButton(Icons.add),
                ),
              ],
            ),
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

  Widget _buildQtyButton(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black, size: 18),
    );
  }
}
