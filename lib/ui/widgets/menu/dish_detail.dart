import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/theme/app_colors.dart';

import '../../../data/models/dish_model.dart';
import '../../../providers/focus_provider.dart';
import '../veg_indicator.dart';

class DishDetail extends ConsumerWidget {
  final Dish dish;
  final String categoryName;

  const DishDetail({super.key, required this.dish, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Focus(
      canRequestFocus: false,
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;

          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: hasFocus ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (dish.dish_image.isNotEmpty)
                    Image.network(
                      dish.dish_image,
                      width: double.infinity,
                      height: 242,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_dish.png',
                          width: double.infinity,
                          height: 242,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VegIndicator(color: (dish.dish_type.toLowerCase() == 'veg' ? Colors.green : Colors.red)), // ✅ Using your existing widget
                      const SizedBox(width: 6),
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
                  const SizedBox(height: 12),
                  Text(
                    dish.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dish.description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${dish.dish_price}',
                    style: const TextStyle(color: Colors.amber),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Type: ${dish.dish_type}',
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
