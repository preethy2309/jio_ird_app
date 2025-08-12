import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/dish_model.dart';
import '../../../providers/focus_provider.dart';

class DishDetail extends ConsumerWidget {
  final Dish dish;

  const DishDetail({super.key, required this.dish});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = ref.watch(dishDetailFocusNodeProvider);

    return Focus(
      focusNode: focusNode,
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;

          return Container(
            decoration: BoxDecoration(
              color: Colors.black87,
              border: Border.all(
                color: hasFocus ? Colors.amber : Colors.transparent,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (dish.dish_image.isNotEmpty)
                    Image.network(
                      dish.dish_image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_dish.png',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        );
                      },
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
