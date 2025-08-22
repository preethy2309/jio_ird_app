import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/screens/base_screen.dart';
import 'package:jio_ird/ui/widgets/menu/menu_top_bar/cart_button.dart';
import 'package:jio_ird/ui/widgets/menu/menu_top_bar/veg_toggle.dart';

import '../../data/models/dish_model.dart';
import '../../data/models/food_item.dart';
import '../../providers/focus_provider.dart';
import '../../providers/state_provider.dart';
import '../widgets/menu/category_list.dart';
import '../widgets/menu/dish_detail.dart';
import '../widgets/menu/dish_list.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final vegOnly = ref.watch(vegOnlyProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final focusedDish = ref.watch(focusedDishProvider);
    final categories = ref.watch(mealsProvider);
    final showCategories = ref.watch(showCategoriesProvider);

    if (categories.isEmpty) {
      return const BaseScreen(
          title: "In Room Dining",
          child: Center(child: CircularProgressIndicator()));
    }

    final selectedCat = categories[selectedCategory];
    final allDishes = extractDishesFromCategory(selectedCat);

    final filteredDishes = vegOnly
        ? allDishes
            .where((dish) => dish.dish_type.toLowerCase() == 'veg')
            .toList()
        : allDishes;

    if (categories.isNotEmpty &&
        !ref.watch(vegToggleFocusNodeProvider).hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (showCategories) {
          var index = selectedCategory == -1 ? 0 : selectedCategory;
          ref.read(categoryFocusNodeProvider(index)).requestFocus();
        } else if (filteredDishes.isNotEmpty) {
          var index = ref.watch(focusedDishProvider);
          ref
              .read(dishFocusNodeProvider(index == -1 ? 0 : index))
              .requestFocus();
        }
      });
    }

    return BaseScreen(
      title: "In Room Dining",
      icons: const [VegToggle(), CartButton()],
      child: Row(
        children: [
          // Back arrow
          if (!showCategories)
            Container(
              margin: const EdgeInsets.only(right: 16),
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0x33FFFFFF),
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
            ),

          // Category List
          if (showCategories)
            SizedBox(
              width: 202,
              child: CategoryList(categories: categories),
            ),

          // Dish List
          SizedBox(
            width: showCategories ? 250 : 280,
            child: DishList(dishes: filteredDishes),
          ),

          // Dish Detail
          Expanded(
            child: DishDetail(
              dish: (focusedDish >= 0 && focusedDish < filteredDishes.length)
                  ? filteredDishes[focusedDish]
                  : (filteredDishes.isNotEmpty ? filteredDishes[0] : null),
              categoryName: selectedCat.category_name,
              itemCount : allDishes.length
            ),
          ),
        ],
      ),
    );
  }

  List<Dish> extractDishesFromCategory(FoodItem category) {
    List<Dish> dishes = [];

    if (category.dishes != null) {
      dishes.addAll(category.dishes!);
    }

    if (category.sub_categories != null) {
      for (final sub in category.sub_categories!) {
        dishes.addAll(extractDishesFromCategory(sub));
      }
    }

    return dishes;
  }
}
