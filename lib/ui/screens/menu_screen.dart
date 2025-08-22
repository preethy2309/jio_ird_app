import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/screens/base_screen.dart';
import 'package:jio_ird/ui/widgets/menu/menu_top_bar/cart_button.dart';
import 'package:jio_ird/ui/widgets/menu/menu_top_bar/veg_toggle.dart';
import 'package:jio_ird/ui/widgets/menu/sub_categories_with_image.dart';
import 'package:jio_ird/utils/helper.dart';

import '../../data/models/dish_model.dart';
import '../../data/models/food_item.dart';
import '../../providers/focus_provider.dart';
import '../../providers/state_provider.dart';
import '../widgets/menu/category_list.dart';
import '../widgets/menu/dish_detail.dart';
import '../widgets/menu/dish_list.dart';
import '../widgets/menu/sub_category_list.dart';

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
    final focusedSubCategory = ref.watch(focusedSubCategoryProvider);
    final focusedDish = ref.watch(focusedDishProvider);
    final categories = ref.watch(mealsProvider);
    final showCategories = ref.watch(showCategoriesProvider);
    final showSubCategories = ref.watch(showSubCategoriesProvider);

    if (categories.isEmpty) {
      return const BaseScreen(
          title: "In Room Dining",
          child: Center(child: CircularProgressIndicator()));
    }

    final selectedCat = categories[selectedCategory];
    final allDishes = selectedCat.sub_categories != null &&
            selectedCat.sub_categories!.isNotEmpty &&
            focusedSubCategory >= 0
        ? extractDishesFromCategory(
            selectedCat.sub_categories![focusedSubCategory])
        : extractDishesFromCategory(selectedCat);

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
        } else if (hasSubCategories(ref) && showSubCategories) {
          var index = ref.watch(focusedSubCategoryProvider);
          ref
              .read(subCategoryFocusNodeProvider(index == -1 ? 0 : index))
              .requestFocus();
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
          if (!showCategories || !showSubCategories)
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

          // --- CASE 1: Category + Dish List + Dish Detail ---
          if (showCategories && !hasSubCategories(ref)) ...[
            SizedBox(
              width: 220,
              child: CategoryList(categories: categories),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 280,
              child: DishList(dishes: filteredDishes),
            ),
            Expanded(
              child: DishDetail(
                dish: (focusedDish >= 0 && focusedDish < filteredDishes.length)
                    ? filteredDishes[focusedDish]
                    : (filteredDishes.isNotEmpty ? filteredDishes[0] : null),
                categoryName: selectedCat.category_name,
                itemCount: allDishes.length,
              ),
            ),
          ]

          // --- CASE 2: Category + SubCategory + Dish Detail ---
          else if (showCategories &&
              hasSubCategories(ref) &&
              showSubCategories) ...[
            SizedBox(
              width: 220,
              child: CategoryList(categories: categories),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 280,
              child: SubCategoriesWithImage(
                  subCategories: selectedCat.sub_categories!),
            ),
            Expanded(
              child: DishDetail(
                dish: (focusedDish >= 0 && focusedDish < filteredDishes.length)
                    ? filteredDishes[focusedDish]
                    : (filteredDishes.isNotEmpty ? filteredDishes[0] : null),
                categoryName: selectedCat.category_name,
                itemCount: allDishes.length,
              ),
            ),
          ]

          // --- CASE 3: SubCategory + Dish List + Dish Detail ---
          else if (hasSubCategories(ref) && showSubCategories) ...[
            SizedBox(
              width: 180,
              child:
                  SubCategoryList(subCategories: selectedCat.sub_categories!),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 280,
              child: DishList(dishes: filteredDishes),
            ),
            Expanded(
              child: DishDetail(
                dish: (focusedDish >= 0 && focusedDish < filteredDishes.length)
                    ? filteredDishes[focusedDish]
                    : (filteredDishes.isNotEmpty ? filteredDishes[0] : null),
                categoryName: selectedCat
                    .sub_categories![focusedSubCategory].category_name,
                itemCount: allDishes.length,
              ),
            ),
          ]

          // --- CASE 4: Only Dish List + Dish Detail ---
          else ...[
            SizedBox(
              width: 280,
              child: DishList(dishes: filteredDishes),
            ),
            Expanded(
              child: DishDetail(
                dish: (focusedDish >= 0 && focusedDish < filteredDishes.length)
                    ? filteredDishes[focusedDish]
                    : (filteredDishes.isNotEmpty ? filteredDishes[0] : null),
                categoryName: selectedCat.category_name,
                itemCount: allDishes.length,
              ),
            ),
          ],
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
