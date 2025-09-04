import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/dish_model.dart';
import '../../../../../notifiers/cart_notifier.dart';
import '../../../../../providers/state_provider.dart';
import '../../../../../utils/helper.dart';
import 'cooking_instruction_button.dart';
import 'dish_header.dart';
import 'dish_info.dart';

class DishDetail extends ConsumerWidget {
  final Dish? dish;
  final String categoryName;
  final int itemCount;

  const DishDetail({
    super.key,
    required this.dish,
    required this.categoryName,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (dish == null) {
      return const Center(child: Text("No dish available"));
    }

    final cartItems = ref.watch(itemQuantitiesProvider);
    final isInCart = cartItems.any((item) => item.dish.id == dish!.id);

    final focusedDish = ref.watch(focusedDishProvider);
    final isCategory = focusedDish == -1 ||
        (hasSubCategories(ref) && ref.read(showSubCategoriesProvider)) ||
        ref.read(showCategoriesProvider);

    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: isCategory
          ? DishHeader(
              categoryName: categoryName,
              itemCount: itemCount,
              dish: dish!,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DishInfo(dish: dish!, categoryName: categoryName),
                if (isInCart) CookingInstructionButton(dish: dish!),
              ],
            ),
    );
  }
}
