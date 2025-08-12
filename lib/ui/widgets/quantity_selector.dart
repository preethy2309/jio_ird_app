import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onIncrement,
            child: _buildQtyButton(Icons.add),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              quantity.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          InkWell(
            onTap: onDecrement,
            child: _buildQtyButton(Icons.remove),
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
