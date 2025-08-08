import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/food_item.dart';
import '../../../../providers/state_provider.dart';
import '../../../../providers/focus_provider.dart'; // <- import focus providers

class CategoryList extends ConsumerWidget {
  final List<FoodItem> categories;

  const CategoryList({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final isSelected = index == selectedCategory;
        final focusNode = ref.watch(categoryFocusNodeProvider(index));
        final firstDishFocusNode = ref.watch(dishFocusNodeProvider(0));

        return Focus(
          focusNode: focusNode,
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              ref.read(selectedCategoryProvider.notifier).state = index;
              ref.read(selectedDishProvider.notifier).state = -1;
              ref.read(canFocusDishListProvider.notifier).state = false;
            }
          },
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.arrowRight ||
                    event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.select)) {
              ref.read(showCategoriesProvider.notifier).state = false;
              ref.read(canFocusDishListProvider.notifier).state = true;

              Future.delayed(const Duration(milliseconds: 50), () {
                firstDishFocusNode.requestFocus();
              });

              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.amber,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              categories[index].category_name,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
