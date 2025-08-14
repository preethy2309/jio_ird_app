import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/theme/app_colors.dart';

import '../../../data/models/dish_with_quantity.dart';
import '../../../providers/focus_provider.dart';
import '../../../providers/state_provider.dart';
import '../quantity_selector.dart';

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

    final dishFocusNodes = ref.watch(dishFocusNodesProvider);
    final showCategories = ref.watch(showCategoriesProvider);

    final FocusNode plusFocusNode = FocusNode();
    final FocusNode minusFocusNode = FocusNode();

    return ListView.builder(
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        final dish = dishes[index];
        final isSelected = index == selectedDish;
        final isFocused = index == focusedDish;

        final node = dishFocusNodes[index];
        if (focusedDish == index) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (node.canRequestFocus) {
              node.requestFocus();
            }
          });
        }

        return Focus(
          focusNode: node,
          skipTraversal: showCategories,
          canRequestFocus: !showCategories,
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              if (selectedDish != focusedDish) {
                ref.read(selectedDishProvider.notifier).state = -1;
              }
              ref.read(focusedDishProvider.notifier).state = index;
            }
          },
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                ref.read(showCategoriesProvider.notifier).state = true;
              }
              if ((event.logicalKey == LogicalKeyboardKey.enter ||
                  event.logicalKey == LogicalKeyboardKey.select)) {
                plusFocusNode.requestFocus();
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
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () {
              ref.read(selectedDishProvider.notifier).state = index;
              ref.read(focusedDishProvider.notifier).state = index;
              plusFocusNode.requestFocus();
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
              height: 76,
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isFocused ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      dish.dish_image,
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_dish.png',
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (isSelected)
                    QuantitySelector(
                      quantity: dish.quantity,
                      onIncrement: () {
                        final currentList = [...itemQuantities];
                        final existingIndex =
                            currentList.indexWhere((e) => e.dish.id == dish.id);
                        if (existingIndex >= 0) {
                          currentList[existingIndex].quantity++;
                        } else {
                          currentList
                              .add(DishWithQuantity(dish: dish, quantity: 1));
                        }
                        ref.read(itemQuantitiesProvider.notifier).state =
                            currentList;
                      },
                      onDecrement: () {
                        final currentList = [...itemQuantities];
                        final existingIndex =
                            currentList.indexWhere((e) => e.dish.id == dish.id);
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
                      plusButtonFocusNode: plusFocusNode,
                      minusButtonFocusNode: minusFocusNode,
                    )
                  else
                    Expanded(
                      child: Text(
                        dish.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
