import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/category_list/category_list.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/dish_detail/dish_detail.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/dish_list/dish_list.dart';

import '../../../data/models/dish_model.dart';
import '../../../data/models/food_item.dart';
import '../../../providers/focus_provider.dart';
import '../../../providers/state_provider.dart';
import '../../../utils/helper.dart';


/// --- UI Builders ---

Widget buildCategoryList(List<FoodItem> categories) {
  return SizedBox(
    width: 202,
    child: CategoryList(categories: categories),
  );
}

Widget buildDishList(List<Dish> dishes, {required double width}) {
  return SizedBox(
    width: width,
    child: DishList(dishes: dishes),
  );
}

Widget buildDishDetail(
  List<Dish> dishes,
  int focusedDish,
  String categoryName,
) {
  if (dishes.isEmpty) {
    return const Expanded(
      child: Center(
        child: Text(
          "No dishes available",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }

  final dish = (focusedDish >= 0 && focusedDish < dishes.length)
      ? dishes[focusedDish]
      : dishes.first;

  return Expanded(
    child: DishDetail(
      dish: dish,
      categoryName: categoryName,
      itemCount: dishes.length,
    ),
  );
}

/// --- Data Helpers ---

List<Dish> extractDishes(FoodItem category, int focusedSubCategory) {
  if (category.subCategories != null &&
      category.subCategories!.isNotEmpty &&
      focusedSubCategory >= 0) {
    return _flattenDishes(category.subCategories![focusedSubCategory]);
  }
  return _flattenDishes(category);
}

List<Dish> _flattenDishes(FoodItem category) {
  final dishes = <Dish>[];
  if (category.dishes != null) {
    dishes.addAll(category.dishes!);
  }
  if (category.subCategories != null) {
    for (final sub in category.subCategories!) {
      dishes.addAll(_flattenDishes(sub));
    }
  }
  return dishes;
}

/// --- Focus Helpers ---

void restoreFocus(
  WidgetRef ref,
  List<FoodItem> categories,
  int selectedCategory,
  List<Dish> filteredDishes,
) {
  if (categories.isEmpty || ref.watch(vegToggleFocusNodeProvider).hasFocus) {
    return;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (ref.watch(showCategoriesProvider)) {
      final index = selectedCategory == -1 ? 0 : selectedCategory;
      ref.read(categoryFocusNodeProvider(index)).requestFocus();
    } else if (hasSubCategories(ref) && ref.watch(showSubCategoriesProvider)) {
      final index = ref.watch(focusedSubCategoryProvider);
      ref
          .read(subCategoryFocusNodeProvider(index == -1 ? 0 : index))
          .requestFocus();
    } else if (filteredDishes.isNotEmpty) {
      final index = ref.watch(focusedDishProvider);
      ref.read(dishFocusNodeProvider(index == -1 ? 0 : index)).requestFocus();
    }
  });
}
