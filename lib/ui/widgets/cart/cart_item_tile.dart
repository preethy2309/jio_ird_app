import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final String title;
  final int quantity;
  final double price;

  const CartItemTile({
    super.key,
    required this.title,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Veg/Non-Veg dot + Title in same row
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.green, width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
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

          Spacer(),
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
                _buildQtyButton(Icons.remove),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                _buildQtyButton(Icons.add),
              ],
            ),
          ),

          const SizedBox(width: 12),

          const Spacer(),
          // Price
          Text(
            "₹${price.toStringAsFixed(0)}",
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
