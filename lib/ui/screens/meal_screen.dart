import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/state_provider.dart';
import '../../providers/focus_provider.dart';
import '../widgets/menu/bottom_layout.dart';
import '../widgets/menu/category_list.dart';
import '../widgets/menu/dish_detail.dart';
import '../widgets/menu/dish_list.dart';
import '../widgets/menu/menu_top_bar/menu_top_bar.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  bool _hasFocusedOnce = false;

  @override
  Widget build(BuildContext context) {
    final vegOnly = ref.watch(vegOnlyProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final focusedDish = ref.watch(focusedDishProvider);
    final mealsAsync = ref.watch(mealsProvider);
    final showCategories = ref.watch(showCategoriesProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: mealsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (categories) {
          final selectedCat = categories[selectedCategory];
          final subCategories = selectedCat.sub_categories ?? [];

          final allDishes =
          subCategories.expand((subCat) => subCat.dishes ?? []).toList();

          final filteredDishes = vegOnly
              ? allDishes
              .where((dish) => dish.dish_type.toLowerCase() == 'veg')
              .toList()
              : allDishes;

          // Initial focus logic
          if (!_hasFocusedOnce && categories.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (showCategories) {
                ref
                    .read(categoryFocusNodeProvider(0))
                    .requestFocus();
              } else if (filteredDishes.isNotEmpty) {
                ref.read(dishFocusNodeProvider(0)).requestFocus();
              }
            });
            _hasFocusedOnce = true;
          }

          return Column(
            children: [
              const MenuTopBar(),
              Expanded(
                child: Row(
                  children: [
                    // ← Back Arrow
                    if (!showCategories)
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.amber,
                            size: 30,
                          ),
                          SizedBox(width: 100),
                        ],
                      ),

                    // Category List
                    if (showCategories)
                      Expanded(
                        flex: 2,
                        child: CategoryList(
                          categories: categories,
                        ),
                      ),

                    // Dish List
                    Expanded(
                      flex: showCategories ? 2 : 3,
                      child: DishList(
                        dishes: filteredDishes,
                      ),
                    ),

                    // Dish Detail
                    Expanded(
                      flex: showCategories ? 4 : 6,
                      child: DishDetail(dish: filteredDishes[focusedDish]),
                    ),
                  ],
                ),
              ),
              const BottomLayout(),
            ],
          );
        },
      ),
    );
  }
}