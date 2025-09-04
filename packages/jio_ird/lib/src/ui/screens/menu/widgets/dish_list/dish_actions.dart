import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/dish_with_quantity.dart';
import '../../../../../notifiers/cart_notifier.dart';
import '../../../../../providers/focus_provider.dart';
import '../../../../../providers/state_provider.dart';
import '../../../../../utils/helper.dart';
import '../../../../widgets/quantity_selector.dart';

class DishActions {
  static Widget buildContent({
    required BuildContext context,
    required WidgetRef ref,
    required dynamic dish,
    required bool isFocused,
    required int quantity,
    required FocusNode plusNode,
    required FocusNode minusNode,
    required Future<void> Function(FocusNode) ensureVisible,
  }) {
    final itemQuantities = ref.watch(itemQuantitiesProvider);

    if (!isFocused) {
      return Text(
        dish.name,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }

    if (quantity == 0) {
      return ElevatedButton(
        onPressed: () {
          ref.read(itemQuantitiesProvider.notifier).addItem(
                DishWithQuantity(dish: dish, quantity: 1),
              );
          Future.microtask(() {
            plusNode.requestFocus();
            ensureVisible(plusNode);
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white70,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          textStyle: const TextStyle(fontSize: 14),
        ),
        child: const Text("Add to Cart"),
      );
    }

    return QuantitySelector(
      quantity: quantity,
      onIncrement: () {
        final idx = itemQuantities.indexWhere((e) => e.dish.id == dish.id);
        if (idx >= 0) {
          ref.read(itemQuantitiesProvider.notifier).increment(idx);
          Future.microtask(() {
            plusNode.requestFocus();
            ensureVisible(plusNode);
          });
        }
      },
      onDecrement: () {
        final idx = itemQuantities.indexWhere((e) => e.dish.id == dish.id);
        if (idx >= 0) {
          ref.read(itemQuantitiesProvider.notifier).decrement(idx);
          Future.microtask(() {
            minusNode.requestFocus();
            ensureVisible(minusNode);
          });
        }
      },
      plusButtonFocusNode: plusNode,
      minusButtonFocusNode: minusNode,
    );
  }

  static KeyEventResult handleKeyEvent({
    required KeyEvent event,
    required bool isFocused,
    required int quantity,
    required WidgetRef ref,
    required dynamic dish,
    required FocusNode plusNode,
    required FocusNode minusNode,
    required Future<void> Function(FocusNode) ensureVisible,
  }) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (!isFocused) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      if (minusNode.hasFocus) {
        Future.microtask(() {
          plusNode.requestFocus();
          ensureVisible(plusNode);
        });
        return KeyEventResult.handled;
      } else {
        if (hasSubCategories(ref)) {
          ref.read(showSubCategoriesProvider.notifier).state = true;
          ref.read(focusedDishProvider.notifier).state = -1;
        } else {
          ref.read(showCategoriesProvider.notifier).state = true;
        }
      }
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      if (minusNode.hasFocus || quantity == 0) {
        ref.read(cookingInstructionFocusNodeProvider).requestFocus();
        return KeyEventResult.handled;
      } else {
        Future.microtask(() {
          minusNode.requestFocus();
          ensureVisible(minusNode);
        });
        return KeyEventResult.handled;
      }
    }

    if (event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.select) {
      final itemQuantities = ref.read(itemQuantitiesProvider);
      final idx = itemQuantities.indexWhere((e) => e.dish.id == dish.id);
      final currentQty = idx >= 0 ? itemQuantities[idx].quantity : 0;

      if (currentQty == 0) {
        ref
            .read(itemQuantitiesProvider.notifier)
            .addItem(DishWithQuantity(dish: dish, quantity: 1));
        Future.microtask(() {
          plusNode.requestFocus();
          ensureVisible(plusNode);
        });
      } else {
        Future.microtask(() {
          if (plusNode.hasFocus ||
              (!plusNode.hasFocus && !minusNode.hasFocus)) {
            ref.read(itemQuantitiesProvider.notifier).increment(idx);
            plusNode.requestFocus();
            ensureVisible(plusNode);
          } else if (minusNode.hasFocus) {
            ref.read(itemQuantitiesProvider.notifier).decrement(idx);
            minusNode.requestFocus();
            ensureVisible(minusNode);
          }
        });
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
