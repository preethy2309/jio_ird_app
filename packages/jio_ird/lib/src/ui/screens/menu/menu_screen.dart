import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/back_arrow_button.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/category_list/category_list.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/dish_detail/dish_detail.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/dish_list/dish_list.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/menu_loading_view.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/sub_category_list/sub_categories_with_image.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/sub_category_list/sub_category_list.dart';

import '../../../data/models/dish_model.dart';
import '../../../data/models/food_item.dart';
import '../../../notifiers/meal_notifier.dart';
import '../../../providers/external_providers.dart';
import '../../../providers/focus_provider.dart';
import '../../../providers/state_provider.dart';
import '../../../utils/helper.dart';
import '../base/base_screen.dart';
import '../base/widgets/menu_top_bar/cart_button.dart';
import '../base/widgets/menu_top_bar/veg_toggle.dart';

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
    final menuTitle = ref.watch(menuTitleProvider);

    if (categories.isEmpty) {
      return BaseScreen(title: menuTitle, child: const MenuLoadingView());
    }

    final selectedCat = categories[selectedCategory];
    final allDishes = _extractDishes(
      selectedCat,
      focusedSubCategory,
    );

    final filteredDishes = vegOnly
        ? allDishes
        .where((dish) => dish.dishType.toLowerCase() == 'veg')
        .toList()
        : allDishes;

    _restoreFocus(ref, categories, selectedCategory, filteredDishes);

    return BaseScreen(
      title: menuTitle,
      icons: const [VegToggle(), CartButton()],
      child: Row(
        children: [
          if (!showCategories || !showSubCategories)
            BackArrowButton(color: Theme.of(context).primaryColor),

          // --- CASE 1: Category + Dish List + Dish Detail ---
          if (showCategories && !hasSubCategories(ref)) ...[
            _buildCategoryList(categories),
            const SizedBox(width: 16),
            _buildDishList(filteredDishes, width: 240),
            _buildDishDetail(
              filteredDishes,
              focusedDish,
              selectedCat.categoryName ?? '',
            ),
          ]

          // --- CASE 2: Category + SubCategory + Dish Detail ---
          else if (showCategories &&
              hasSubCategories(ref) &&
              showSubCategories) ...[
            _buildCategoryList(categories),
            const SizedBox(width: 16),
            SizedBox(
              width: 240,
              child: SubCategoriesWithImage(
                subCategories: selectedCat.subCategories!,
              ),
            ),
            _buildDishDetail(
              filteredDishes,
              focusedDish,
              selectedCat.categoryName ?? '',
            ),
          ]

          // --- CASE 3: SubCategory + Dish List + Dish Detail ---
          else if (hasSubCategories(ref) && showSubCategories) ...[
              SizedBox(
                width: 202,
                child: SubCategoryList(subCategories: selectedCat.subCategories!),
              ),
              const SizedBox(width: 16),
              _buildDishList(filteredDishes, width: 280),
              _buildDishDetail(
                filteredDishes,
                focusedDish,
                selectedCat.subCategories![focusedSubCategory].categoryName ?? '',
              ),
            ]

            // --- CASE 4: Only Dish List + Dish Detail ---
            else ...[
                _buildDishList(filteredDishes, width: 280),
                _buildDishDetail(
                  filteredDishes,
                  focusedDish,
                  selectedCat.categoryName ?? '',
                ),
              ],
        ],
      ),
    );
  }

  /// --- Helpers ---

  Widget _buildCategoryList(List<FoodItem> categories) {
    return SizedBox(
      width: 202,
      child: CategoryList(categories: categories),
    );
  }

  Widget _buildDishList(List<Dish> dishes, {required double width}) {
    return SizedBox(
      width: width,
      child: DishList(dishes: dishes),
    );
  }

  Widget _buildDishDetail(
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

  List<Dish> _extractDishes(FoodItem category, int focusedSubCategory) {
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

  void _restoreFocus(
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
        ref.read(subCategoryFocusNodeProvider(index == -1 ? 0 : index))
            .requestFocus();
      } else if (filteredDishes.isNotEmpty) {
        final index = ref.watch(focusedDishProvider);
        ref.read(dishFocusNodeProvider(index == -1 ? 0 : index)).requestFocus();
      }
    });
  }
}