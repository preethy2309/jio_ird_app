import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/screens/base_screen.dart';
import 'package:jio_ird/ui/widgets/menu/menu_top_bar/cart_button.dart';
import 'package:jio_ird/ui/widgets/menu/menu_top_bar/veg_toggle.dart';

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
    final selectedSubCategory = ref.watch(selectedSubCategoryProvider);
    final focusedDish = ref.watch(focusedDishProvider);
    final mealsAsync = ref.watch(mealsProvider);
    final showCategories = ref.watch(showCategoriesProvider);

    return mealsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (categories) {
        final selectedCat = categories[selectedCategory];
        final subCategories = selectedCat.sub_categories ?? [];

        final allDishes = (selectedSubCategory >= 0 && selectedSubCategory < subCategories.length)
            ? (subCategories[selectedSubCategory].dishes ?? [])
            : subCategories.expand((subCat) => subCat.dishes ?? []).toList();


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
            } else if(subCategories.isNotEmpty){
              final selectedSubCat = ref.watch(selectedSubCategoryProvider);
              var index = selectedSubCat == -1 ? 0 : selectedSubCat;
              ref.read(subCategoryFocusNodeProvider(index)).requestFocus();
            } else if (filteredDishes.isNotEmpty) {
              final focusedSubCat = ref.read(focusedSubCategoryProvider);
              final fallback = ref.read(selectedSubCategoryProvider);
              final index = focusedSubCat != -1
                  ? focusedSubCat
                  : (fallback != -1 ? fallback : 0);

              if (index < subCategories.length) {
                ref.read(subCategoryFocusNodeProvider(index)).requestFocus();
              }
            }
          });
        }

        return BaseScreen(
          title: "In Room Dining",
          description: "Room No. 204",
          icons: const [VegToggle(), CartButton()],
          child: Row(
            children: [
              // Category List
              if (showCategories)
                SizedBox(
                  width: 202,
                  child: CategoryList(categories: categories),
                ),

              // SubCategory List (if exists)
              if (subCategories.isNotEmpty)
                SizedBox(
                  width: 200,
                  child: SubCategoryList(subCategories: subCategories),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
