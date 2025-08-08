import 'package:flutter/material.dart';

class OrderPlaced extends StatelessWidget {
  const OrderPlaced({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber,
            child: Icon(Icons.check, size: 30, color: Colors.black),
          ),
          const SizedBox(height: 16),
          const Text(
            "Order Placed !",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Your order was placed successfully",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              // Navigate to tracking screen
            },
            child: const Text(
              "Track order",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
