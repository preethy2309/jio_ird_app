import 'package:flutter/material.dart';

class DeliveryInfoPanel extends StatelessWidget {
  const DeliveryInfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Delivery Info",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Estimated delivery time
        Row(
          children: const [
            Icon(Icons.timer, color: Colors.amber),
            SizedBox(width: 8),
            Text(
              "Delivered in 30 mins",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Guest Count Dropdown (mock)
        const Text(
          "Guest Count",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text("2 Guests", style: TextStyle(color: Colors.white)),
        ),

        const SizedBox(height: 20),

        // Allergies
        const Text(
          "Allergies or Restrictions",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "No peanuts",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Instructions
        const Text(
          "Instructions",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Please deliver hot and fresh.",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ),

        const SizedBox(height: 30),

        // Place Order Button
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.shade600,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              "PLACE ORDER - ₹320",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
