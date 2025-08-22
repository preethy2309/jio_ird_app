import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/food_item.dart';
import '../../../providers/focus_provider.dart';
import '../../../providers/state_provider.dart';
import 'category_tile.dart';

class SubCategoryList extends ConsumerStatefulWidget {
  final List<FoodItem> subCategories;

  const SubCategoryList({super.key, required this.subCategories});

  @override
  ConsumerState<SubCategoryList> createState() => _SubCategoryListState();
}

class _SubCategoryListState extends ConsumerState<SubCategoryList> {

  @override
  Widget build(BuildContext context) {
    final selectedSub = ref.watch(selectedSubCategoryProvider);
    final focusedIndex = ref.watch(focusedSubCategoryProvider);
    final showCategories = ref.watch(showCategoriesProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          ref.read(showCategoriesProvider.notifier).state = true;
        }
      },
      child: Focus(
        skipTraversal: showCategories,
        canRequestFocus: !showCategories,
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            ref.read(focusedSubCategoryProvider.notifier).state = -1;
          }
        },
        child: ListView.builder(
          itemCount: widget.subCategories.length,
          itemBuilder: (context, index) {
            final isSelected = index == selectedSub;
            final isFocused = index == focusedIndex;
            print("Preethy $isSelected $isFocused");

            final focusNode = ref.watch(subCategoryFocusNodeProvider(index));

            return CategoryTile(
              title: widget.subCategories[index].category_name,
              index: index,
              isSelected: isSelected,
              isFocused: isFocused,
              focusNode: focusNode,
              isLastIndex: index == widget.subCategories.length - 1,
              onSelect: () {
                ref.read(selectedSubCategoryProvider.notifier).state = index;
                ref.read(focusedDishProvider.notifier).state = -1;
                ref.read(showSubCategoriesProvider.notifier).state = false;
              },
              onFocusChange: (hasFocus) {
                ref.read(focusedSubCategoryProvider.notifier).state = index;
                if (hasFocus) {
                  ref.read(selectedSubCategoryProvider.notifier).state = index;
                  ref.read(selectedDishProvider.notifier).state = -1;
                  ref.read(focusedDishProvider.notifier).state = -1;
                }
              },
              onLeft: () {
                ref.read(showCategoriesProvider.notifier).state = true;
                ref.read(selectedSubCategoryProvider.notifier).state = -1;
              },
            );
          },
        ),
      ),
    );
  }
}
