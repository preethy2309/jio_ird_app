import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/back_arrow_button.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/menu_loading_view.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/sub_category_list/sub_categories_with_image.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/sub_category_list/sub_category_list.dart';

import '../../../notifiers/meal_notifier.dart';
import '../../../providers/external_providers.dart';
import '../../../providers/state_provider.dart';
import '../../../utils/helper.dart';
import '../base/base_screen.dart';
import '../base/widgets/menu_top_bar/cart_button.dart';
import '../base/widgets/menu_top_bar/veg_toggle.dart';
import 'menu_helper.dart';

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
    final allDishes = extractDishes(
      selectedCat,
      focusedSubCategory,
    );

    final filteredDishes = vegOnly
        ? allDishes
            .where((dish) => dish.dishType.toLowerCase() == 'veg')
            .toList()
        : allDishes;

    restoreFocus(ref, categories, selectedCategory, filteredDishes);

    return BaseScreen(
      title: menuTitle,
      icons: const [VegToggle(), CartButton()],
      child: Row(
        children: [
          if (!showCategories || !showSubCategories)
            BackArrowButton(color: Theme.of(context).primaryColor),

          // --- CASE 1: Category + Dish List + Dish Detail ---
          if (showCategories && !hasSubCategories(ref)) ...[
            buildCategoryList(categories),
            const SizedBox(width: 16),
            buildDishList(filteredDishes, width: 240),
            buildDishDetail(
              filteredDishes,
              focusedDish,
              selectedCat.categoryName ?? '',
            ),
          ]

          // --- CASE 2: Category + SubCategory + Dish Detail ---
          else if (showCategories &&
              hasSubCategories(ref) &&
              showSubCategories) ...[
            buildCategoryList(categories),
            const SizedBox(width: 16),
            SizedBox(
              width: 240,
              child: SubCategoriesWithImage(
                subCategories: selectedCat.subCategories!,
              ),
            ),
            buildDishDetail(
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
            buildDishList(filteredDishes, width: 280),
            buildDishDetail(
              filteredDishes,
              focusedDish,
              selectedCat.subCategories![focusedSubCategory].categoryName ?? '',
            ),
          ]

          // --- CASE 4: Only Dish List + Dish Detail ---
          else ...[
            buildDishList(filteredDishes, width: 280),
            buildDishDetail(
              filteredDishes,
              focusedDish,
              selectedCat.categoryName ?? '',
            ),
          ],
        ],
      ),
    );
  }
}
