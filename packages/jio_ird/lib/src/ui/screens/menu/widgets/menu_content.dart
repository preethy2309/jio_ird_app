import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/dish_model.dart';
import '../../../../data/models/food_item.dart';
import '../../../../providers/focus_provider.dart';
import '../../../../providers/state_provider.dart';
import '../../../../utils/helper.dart';
import 'category_dish_view.dart';
import 'category_subcategory_view.dart';
import 'dish_only_view.dart';
import 'subcategory_dish_view.dart';
import 'back_arrow_button.dart';

class MenuContent extends ConsumerWidget {
  final List<FoodItem> categories;

  const MenuContent({required this.categories, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vegOnly = ref.watch(vegOnlyProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final focusedSubCategory = ref.watch(focusedSubCategoryProvider);
    final focusedDish = ref.watch(focusedDishProvider);
    final showCategories = ref.watch(showCategoriesProvider);
    final showSubCategories = ref.watch(showSubCategoriesProvider);

    final selectedCat = categories[selectedCategory];
    final allDishes = _extractDishes(selectedCat, focusedSubCategory);
    final filteredDishes = vegOnly
        ? allDishes.where((d) => d.dishType.toLowerCase() == 'veg').toList()
        : allDishes;

    _restoreFocus(ref, categories, selectedCategory, filteredDishes);
    return Row(
      children: [
        if (!showCategories || !showSubCategories)
          BackArrowButton(color: Theme.of(context).primaryColor),
        if (showCategories && !hasSubCategories(ref))
          CategoryDishView(
            categories: categories,
            selectedCat: selectedCat,
            filteredDishes: filteredDishes,
            focusedDish: focusedDish,
          )
        else if (showCategories && hasSubCategories(ref) && showSubCategories)
          CategorySubCategoryView(
            categories: categories,
            selectedCat: selectedCat,
            filteredDishes: filteredDishes,
            focusedDish: focusedDish,
          )
        else if (hasSubCategories(ref) && showSubCategories)
          SubCategoryDishView(
            selectedCat: selectedCat,
            filteredDishes: filteredDishes,
            focusedDish: focusedDish,
            focusedSubCategory: focusedSubCategory,
          )
        else
          DishOnlyView(
            selectedCat: selectedCat,
            filteredDishes: filteredDishes,
            focusedDish: focusedDish,
          ),
      ],
    );
  }

  static List<Dish> _extractDishes(FoodItem category, int focusedSubCategory) {
    if (category.subCategories != null &&
        category.subCategories!.isNotEmpty &&
        focusedSubCategory >= 0) {
      return _extractFromCategory(category.subCategories![focusedSubCategory]);
    }
    return _extractFromCategory(category);
  }

  static List<Dish> _extractFromCategory(FoodItem category) {
    final dishes = <Dish>[];
    if (category.dishes != null) dishes.addAll(category.dishes!);
    if (category.subCategories != null) {
      for (final sub in category.subCategories!) {
        dishes.addAll(_extractFromCategory(sub));
      }
    }
    return dishes;
  }

  void _restoreFocus(
    WidgetRef ref,
    List<FoodItem> categories,
    int selectedCategory,
    List<Dish> dishes,
  ) {
    if (categories.isNotEmpty &&
        !ref.watch(vegToggleFocusNodeProvider).hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (ref.watch(showCategoriesProvider)) {
          final index = selectedCategory == -1 ? 0 : selectedCategory;
          ref.read(categoryFocusNodeProvider(index)).requestFocus();
        } else if (hasSubCategories(ref) &&
            ref.watch(showSubCategoriesProvider)) {
          final index = ref.watch(focusedSubCategoryProvider);
          ref
              .read(subCategoryFocusNodeProvider(index == -1 ? 0 : index))
              .requestFocus();
        } else if (dishes.isNotEmpty) {
          final index = ref.watch(focusedDishProvider);
          ref
              .read(dishFocusNodeProvider(index == -1 ? 0 : index))
              .requestFocus();
        }
      });
    }
  }
}
