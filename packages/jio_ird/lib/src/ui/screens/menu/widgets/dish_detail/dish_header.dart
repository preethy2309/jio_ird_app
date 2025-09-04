import 'package:flutter/material.dart';
import '../dish_image.dart';
import '../../../../../data/models/dish_model.dart';

class DishHeader extends StatelessWidget {
  final Dish dish;
  final String categoryName;
  final int itemCount;

  const DishHeader({
    super.key,
    required this.dish,
    required this.categoryName,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DishImage(
          imageUrl: dish.dishImage,
          width: double.infinity,
          height: 220,
          borderRadius: 16,
          fallbackWidth: 120,
          fallbackHeight: 120,
        ),
        const SizedBox(height: 8),
        Text(
          itemCount > 7 ? "7+" : "$itemCount",
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          categoryName,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
