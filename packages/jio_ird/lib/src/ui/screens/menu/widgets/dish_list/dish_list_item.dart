import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/dish_with_quantity.dart';
import '../../../../../notifiers/cart_notifier.dart';
import '../../../../../providers/state_provider.dart';
import '../../../../../utils/helper.dart';
import '../dish_image.dart';
import 'dish_actions.dart';

class DishListItem extends ConsumerWidget {
  final dynamic dish;
  final int index;
  final FocusNode dishNode;
  final FocusNode plusNode;
  final FocusNode minusNode;
  final ScrollController scrollController;
  final bool isSelected;
  final bool isFocused;

  const DishListItem({
    super.key,
    required this.dish,
    required this.index,
    required this.dishNode,
    required this.plusNode,
    required this.minusNode,
    required this.scrollController,
    required this.isSelected,
    required this.isFocused,
  });

  Future<void> _ensureVisible(FocusNode node) async {
    if (node.context != null) {
      await Scrollable.ensureVisible(
        node.context!,
        alignment: 0.5,
        duration: const Duration(milliseconds: 200),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemQuantities = ref.watch(itemQuantitiesProvider);
    final quantity = ref.watch(itemQuantitiesProvider.select((cart) => cart
        .firstWhere(
          (item) => item.dish.id == dish.id,
          orElse: () => DishWithQuantity(dish: dish, quantity: 0),
        )
        .quantity));
    final showCategories = ref.watch(showCategoriesProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop && isFocused) {
          if (hasSubCategories(ref)) {
            ref.read(showSubCategoriesProvider.notifier).state = true;
            ref.read(focusedDishProvider.notifier).state = -1;
          } else {
            ref.read(showCategoriesProvider.notifier).state = true;
          }
        }
      },
      child: Focus(
        focusNode: dishNode,
        skipTraversal: showCategories || isSelected,
        canRequestFocus: !showCategories && !isSelected,
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            ref.read(focusedDishProvider.notifier).state = index;
            _ensureVisible(dishNode);
            if (ref.read(selectedDishProvider) !=
                ref.read(focusedDishProvider)) {
              ref.read(selectedDishProvider.notifier).state = -1;
            }
            if (quantity != 0) plusNode.requestFocus();
          }
        },
        onKeyEvent: (node, event) => DishActions.handleKeyEvent(
          event: event,
          isFocused: isFocused,
          quantity: quantity,
          ref: ref,
          dish: dish,
          plusNode: plusNode,
          minusNode: minusNode,
          ensureVisible: _ensureVisible,
        ),
        child: InkWell(
          child: Container(
            height: 76,
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isFocused
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                DishImage(
                  imageUrl: dish.dishImage,
                  width: 75,
                  height: 75,
                  borderRadius: 6,
                  fallbackWidth: 45,
                  fallbackHeight: 45,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DishActions.buildContent(
                    context: context,
                    ref: ref,
                    dish: dish,
                    isFocused: isFocused,
                    quantity: quantity,
                    plusNode: plusNode,
                    minusNode: minusNode,
                    ensureVisible: _ensureVisible,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
