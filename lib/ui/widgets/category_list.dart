import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../viewmodel/meals_notifier.dart';
import '../../../data/models/food_item.dart';

class CategoryList extends ConsumerWidget {
  final List<FoodItem> categories;
  final List<FocusNode> categoryFocusNodes;

  const CategoryList({
    super.key,
    required this.categories,
    required this.categoryFocusNodes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final isSelected = index == selectedCategory;
        final focusNode = categoryFocusNodes[index];
        return Focus(
          focusNode: focusNode,
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              ref.read(selectedCategoryProvider.notifier).state = index;
              ref.read(selectedDishProvider.notifier).state = 0;
            }
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.amber,
              borderRadius: BorderRadius.circular(8),
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
