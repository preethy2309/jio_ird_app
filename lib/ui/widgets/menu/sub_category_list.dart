// lib/ui/widgets/menu/sub_category_list.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/food_item.dart';
import '../../../../providers/focus_provider.dart';
import '../../../../providers/state_provider.dart';

class SubCategoryList extends ConsumerWidget {
  final List<FoodItem> subCategories;

  const SubCategoryList({super.key, required this.subCategories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSubCategory = ref.watch(selectedSubCategoryProvider);

    return ListView.builder(
      itemCount: subCategories.length,
      itemBuilder: (context, index) {
        final subCategory = subCategories[index];
        final node = ref.read(subCategoryFocusNodeProvider(index));
        final isFocused = node.hasFocus;
        final isSelected = index == selectedSubCategory;

        Focus(
          focusNode: node,
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              ref.read(focusedSubCategoryProvider.notifier).state = index;
            }
          },
          onKey: (node, event) {
            if (event is RawKeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                // Move to first dish
                ref.read(focusedDishProvider.notifier).state = 0;
                final dishNode = ref.read(dishFocusNodeProvider(0));
                Future.microtask(() => dishNode.requestFocus());
                return KeyEventResult.handled;
              } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                // Move back to category list
                ref.read(selectedCategoryProvider.notifier).state = 0;
                final catNode = ref.read(categoryFocusNodeProvider(0));
                Future.microtask(() => catNode.requestFocus());
                return KeyEventResult.handled;
              } else if (event.logicalKey == LogicalKeyboardKey.select ||
                  event.logicalKey == LogicalKeyboardKey.enter) {
                ref.read(selectedSubCategoryProvider.notifier).state = index;
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: isFocused
                  ? Colors.amber
                  : (isSelected ? Colors.amber.withOpacity(0.5) : Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              subCategory.category_name,
              style: TextStyle(
                color: isFocused || isSelected ? Colors.black : Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
