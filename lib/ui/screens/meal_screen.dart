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

          if (categories.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (showCategories) {
                var index = selectedCategory == -1 ? 0 : selectedCategory;
                ref.read(categoryFocusNodeProvider(index)).requestFocus();
              } else if (filteredDishes.isNotEmpty) {
                ref.read(dishFocusNodeProvider(0)).requestFocus();
              }
            });
          }

          return BaseScreen(
            title: "In Room Dining",
            description: "Room No. 204",
            icons: const [VegToggle(), CartButton()],
            child: Column(
              children: [
                const SizedBox(height: 16),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
