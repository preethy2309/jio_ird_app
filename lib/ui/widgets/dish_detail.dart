import 'package:flutter/material.dart';

import '../../data/models/dish_model.dart';

class DishDetail extends StatelessWidget {
  final Dish dish;

  const DishDetail({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dish.dish_image.isNotEmpty)
            Image.network(dish.dish_image,
                width: 300, height: 180, fit: BoxFit.cover),
          const SizedBox(height: 12),
          Text(dish.name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(dish.description, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Text('₹${dish.dish_price}',
              style: const TextStyle(color: Colors.amber)),
          const SizedBox(height: 8),
          Text('Type: ${dish.dish_type}',
              style: const TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}
