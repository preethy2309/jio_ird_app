import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/dish_model.dart';
import '../../../providers/focus_provider.dart';
import '../../../providers/state_provider.dart';
import '../veg_indicator.dart';
import 'cooking_instruction_dialog.dart';

class DishDetail extends ConsumerWidget {
  final Dish? dish;
  final String categoryName;

  const DishDetail({super.key, required this.dish, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (dish == null) {
      return const Center(child: Text("No dish available"));
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dish!.dish_image.isNotEmpty)
            Image.network(
              dish!.dish_image,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/default_dish.png',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                );
              },
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              VegIndicator(
                  size: 6,
                  color: (dish!.dish_type.toLowerCase() == 'veg'
                      ? Colors.green
                      : Colors.red)),
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
          Text(
            '₹${dish!.dish_price}',
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            dish!.name,
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            dish!.description,
            maxLines: 2,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 2),
          if (dish!.cooking_request?.isNotEmpty == true)
            Text(
              'Cooking instruction : ${dish!.cooking_request}',
              maxLines: 1,
              style: const TextStyle(color: Colors.white54),
            ),
          const SizedBox(height: 6),
          Center(
            child: SizedBox(
              height: 35,
              child: Focus(
                onKeyEvent: (node, event) {
                  if (event is! KeyDownEvent) return KeyEventResult.ignored;
                  if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                    if (ref.watch(showCategoriesProvider)) {
                      final lastFocusedCategory =
                          ref.read(selectedCategoryProvider);
                      final categoryIndex =
                          (lastFocusedCategory >= 0) ? lastFocusedCategory : 0;

                      ref
                          .read(categoryFocusNodeProvider(categoryIndex))
                          .requestFocus();
                    } else {
                      final lastFocusedDish = ref.read(focusedDishProvider);
                      int index = 0;
                      if (lastFocusedDish >= 0) {
                        index = lastFocusedDish;
                      }
                      ref.read(dishFocusNodeProvider(index)).requestFocus();
                    }
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: ElevatedButton(
                  focusNode: ref.watch(cookingInstructionFocusNodeProvider),
                  onPressed: () {
                    showDialog(
                      barrierColor: Colors.black87,
                      context: context,
                      builder: (context) {
                        TextEditingController instructionController =
                            TextEditingController();
                        instructionController.text = dish!.cooking_request ?? '';
                        return CookingInstructionDialog(
                          dishName: dish!.name,
                          controller: instructionController,
                          onSave: (text) {
                            ref
                                .read(mealsProvider.notifier)
                                .updateDishCookingInstruction(dish!.id, text);
                            Navigator.of(context).pop();
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(WidgetState.focused)) {
                          return Colors.amber;
                        }
                        return Colors.white70;
                      },
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(WidgetState.focused)) {
                          return Colors.white70;
                        }
                        return Colors.black;
                      },
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: Text(
                    (dish!.cooking_request == null ||
                            dish!.cooking_request!.isEmpty)
                        ? "Add Cooking Instructions"
                        : "Edit Cooking Instructions",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
