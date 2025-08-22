import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/food_item.dart';
import '../../../../providers/focus_provider.dart';
import '../../../../providers/state_provider.dart';
import '../../../utils/helper.dart';
import 'category_tile.dart';

class CategoryList extends ConsumerStatefulWidget {
  final List<FoodItem> categories;

  const CategoryList({super.key, required this.categories});

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
  int focusedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          setState(() => focusedIndex = -1);
        }
      },
      child: ListView.builder(
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedCategory;
          final isFocused = index == focusedIndex;

          final focusNode = ref.watch(categoryFocusNodeProvider(index));

          return CategoryTile(
            title: widget.categories[index].category_name,
            index: index,
            isSelected: isSelected,
            isFocused: isFocused,
            focusNode: focusNode,
            isLastIndex: index == widget.categories.length - 1,
            onSelect: () {
              ref.read(selectedCategoryProvider.notifier).state = index;
              ref.read(selectedDishProvider.notifier).state = -1;
              ref.read(showCategoriesProvider.notifier).state = false;
              if (hasSubCategories(ref)) {
                ref.read(focusedDishProvider.notifier).state = -1;
                ref.read(selectedSubCategoryProvider.notifier).state = 0;
                ref.read(focusedSubCategoryProvider.notifier).state = 0;
              } else {
                ref.read(focusedDishProvider.notifier).state = 0;
                ref.read(focusedSubCategoryProvider.notifier).state = 0;
              }
            },
            onFocusChange: (hasFocus) {
              setState(() {
                focusedIndex = hasFocus ? index : focusedIndex;
              });
              if (hasFocus) {
                ref.read(selectedCategoryProvider.notifier).state = index;
                ref.read(focusedSubCategoryProvider.notifier).state = -1;
                ref.read(selectedSubCategoryProvider.notifier).state = -1;
                ref.read(selectedDishProvider.notifier).state = -1;
                ref.read(focusedDishProvider.notifier).state = -1;
              }
            },
            onLeft: () {},
          );
        },
      ),
    );
  }
}
