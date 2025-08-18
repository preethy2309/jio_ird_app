import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/theme/app_colors.dart';

import '../../../../data/models/food_item.dart';
import '../../../../providers/focus_provider.dart';
import '../../../../providers/state_provider.dart';

class CategoryList extends ConsumerStatefulWidget {
  final List<FoodItem> categories;

  const CategoryList({
    super.key,
    required this.categories,
  });

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
  int focusedIndex = -1; // Track which index is currently focused

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          setState(() {
            focusedIndex = -1;
          });
        }
      },
      child: ListView.builder(
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedCategory;
          final isFocused = index == focusedIndex;

          final focusNode = ref.watch(categoryFocusNodeProvider(index));

          return Focus(
            focusNode: focusNode,
            onFocusChange: (hasFocus) {
              setState(() {
                focusedIndex = hasFocus ? index : focusedIndex;
              });
              if (hasFocus) {
                ref.read(selectedCategoryProvider.notifier).state = index;
                ref.read(selectedDishProvider.notifier).state = -1;
                ref.read(focusedDishProvider.notifier).state = -1;
              }
            },
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent &&
                  (event.logicalKey == LogicalKeyboardKey.arrowRight ||
                      event.logicalKey == LogicalKeyboardKey.enter ||
                      event.logicalKey == LogicalKeyboardKey.select)) {
                ref.read(selectedCategoryProvider.notifier).state = index;
                ref.read(showCategoriesProvider.notifier).state = false;
                ref.read(focusedDishProvider.notifier).state = 0;
                return KeyEventResult.handled;
              }
              return KeyEventResult.ignored;
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: 36,
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isFocused
                    ? Colors.amber
                    : isSelected
                    ? Colors.white70
                    : AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                widget.categories[index].category_name,
                style: TextStyle(
                  color: isFocused || isSelected
                      ? AppColors.primary
                      : Colors.amber,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
