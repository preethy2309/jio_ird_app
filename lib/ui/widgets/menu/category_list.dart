import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/theme/app_colors.dart';

import '../../../../data/models/food_item.dart';
import '../../../../providers/focus_provider.dart';
import '../../../../providers/state_provider.dart';

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

        return Focus(
          focusNode: focusNode,
          onFocusChange: (hasFocus) {
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
              color: isSelected ? Colors.amber : AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              categories[index].category_name,
              style: TextStyle(
                color: !isSelected ? Colors.amber : AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
