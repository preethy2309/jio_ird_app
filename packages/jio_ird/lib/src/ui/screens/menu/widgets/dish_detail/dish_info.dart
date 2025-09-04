import 'package:flutter/material.dart';
import '../../../../../data/models/dish_model.dart';
import '../../../../widgets/veg_indicator.dart';
import '../dish_image.dart';

class DishInfo extends StatelessWidget {
  final Dish dish;
  final String categoryName;

  const DishInfo({
    super.key,
    required this.dish,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final hasPrice = (double.tryParse(dish.dishPrice) ?? 0) > 0;

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
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            VegIndicator(
              size: 6,
              color: dish.dishType.toLowerCase() == 'veg'
                  ? Colors.green
                  : Colors.red,
            ),
            const SizedBox(width: 4),
            Text(
              categoryName,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        if (hasPrice)
          Text(
            '₹${dish.dishPrice}',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        Text(
          dish.name,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          dish.description,
          maxLines: 2,
          style: const TextStyle(color: Colors.white70, height: 1.0),
        ),
        if (dish.cookingRequest?.isNotEmpty == true)
          Text(
            'Cooking instruction : ${dish.cookingRequest}',
            maxLines: 1,
            style: const TextStyle(color: Colors.white54),
          ),
      ],
    );
  }
}
