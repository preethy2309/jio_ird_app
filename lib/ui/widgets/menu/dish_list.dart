import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/dish_with_quantity.dart';
import '../../../providers/focus_provider.dart';
import '../../../providers/state_provider.dart';

class DishList extends ConsumerWidget {
  final List<dynamic> dishes;

  const DishList({
    super.key,
    required this.dishes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDish = ref.watch(selectedDishProvider);
    final focusedDish = ref.watch(focusedDishProvider);
    final itemQuantities = ref.watch(itemQuantitiesProvider);
    final canFocusDishList = ref.watch(canFocusDishListProvider);
    final showCategories = ref.watch(showCategoriesProvider);

    final dishFocusNodes = ref.watch(dishFocusNodesProvider);
    final categoryFocusNodes = ref.watch(categoryFocusNodesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return ListView.builder(
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        final dish = dishes[index];
        final isSelected = index == selectedDish;
        final isFocused = index == focusedDish;

        // Find quantity of this dish from the list, 0 if not found
        final existing = itemQuantities.firstWhere(
          (element) => element.dish.id == dish.id,
          orElse: () => DishWithQuantity(dish: dish, quantity: 0),
        );
        final count = existing.quantity;

        final node = dishFocusNodes[index];

        return Focus(
          focusNode: node,
          skipTraversal: !canFocusDishList,
          canRequestFocus: canFocusDishList,
          onFocusChange: (hasFocus) {
            if (hasFocus && !showCategories) {
              if (selectedDish != focusedDish) {
                ref.read(selectedDishProvider.notifier).state = -1;
              }
              ref.read(focusedDishProvider.notifier).state = index;
            }
          },
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              ref.read(showCategoriesProvider.notifier).state = true;
              ref.read(canFocusDishListProvider.notifier).state = false;

              Future.delayed(const Duration(milliseconds: 50), () {
                final categoryNode = categoryFocusNodes[selectedCategory];
                categoryNode.requestFocus();
              });

              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () {
              ref.read(selectedDishProvider.notifier).state = index;
              ref.read(focusedDishProvider.notifier).state = index;

              final currentList = [...itemQuantities];
              final existingIndex =
                  currentList.indexWhere((e) => e.dish.id == dish.id);
              if (existingIndex >= 0) {
                // Increase quantity
                currentList[existingIndex].quantity++;
              } else {
                currentList.add(DishWithQuantity(dish: dish, quantity: 1));
              }
              ref.read(itemQuantitiesProvider.notifier).state = currentList;
            },
            child: Container(
              height: 90,
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isFocused ? Colors.amber.shade300 : Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      dish.dish_image,
                      width: 80,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      dish.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isSelected)
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            final currentList = [...itemQuantities];
                            final existingIndex = currentList
                                .indexWhere((e) => e.dish.id == dish.id);
                            if (existingIndex >= 0) {
                              final newQty =
                                  currentList[existingIndex].quantity - 1;
                              if (newQty <= 0) {
                                currentList.removeAt(existingIndex);
                              } else {
                                currentList[existingIndex].quantity = newQty;
                              }
                              ref.read(itemQuantitiesProvider.notifier).state =
                                  currentList;
                            }
                          },
                        ),
                        Text('$count',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            final currentList = [...itemQuantities];
                            final existingIndex = currentList
                                .indexWhere((e) => e.dish.id == dish.id);
                            if (existingIndex >= 0) {
                              currentList[existingIndex].quantity++;
                            } else {
                              currentList.add(
                                  DishWithQuantity(dish: dish, quantity: 1));
                            }
                            ref.read(itemQuantitiesProvider.notifier).state =
                                currentList;
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
