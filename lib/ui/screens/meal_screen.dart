import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/data_provider.dart';
import '../widgets/bottom_layout.dart';
import '../widgets/category_list.dart';
import '../widgets/dish_detail.dart';
import '../widgets/dish_list.dart';
import '../widgets/menu_top_bar/menu_top_bar.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  final List<FocusNode> categoryFocusNodes = [];
  final List<FocusNode> dishFocusNodes = [];

  bool isBackFocused = false;
  bool _hasFocusedOnce = false;

  @override
  void dispose() {
    for (final node in categoryFocusNodes) {
      node.dispose();
    }
    for (final node in dishFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vegOnly = ref.watch(vegOnlyProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final focusedDish = ref.watch(focusedDishProvider);
    final selectedDish = ref.watch(selectedDishProvider);
    final mealsAsync = ref.watch(mealsProvider);
    final showCategories = ref.watch(showCategoriesProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: mealsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (categories) {
          if (categoryFocusNodes.length != categories.length) {
            categoryFocusNodes
              ..clear()
              ..addAll(List.generate(categories.length, (_) => FocusNode()));
          }

          if (!_hasFocusedOnce && categoryFocusNodes.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (showCategories) {
                categoryFocusNodes[0].requestFocus();
              } else if (dishFocusNodes.isNotEmpty) {
                dishFocusNodes[0].requestFocus();
              }
            });
            _hasFocusedOnce = true;
          }

          final selectedCat = categories[selectedCategory];
          final subCategories = selectedCat.sub_categories ?? [];

          final allDishes =
              subCategories.expand((subCat) => subCat.dishes ?? []).toList();

          final filteredDishes = vegOnly
              ? allDishes
                  .where((dish) => dish.dish_type.toLowerCase() == 'veg')
                  .toList()
              : allDishes;

          if (dishFocusNodes.length != filteredDishes.length) {
            dishFocusNodes
              ..clear()
              ..addAll(
                  List.generate(filteredDishes.length, (_) => FocusNode()));
          }

          return Column(
            children: [
              const MenuTopBar(),
              Expanded(
                child: Row(
                  children: [
                    // ← Back Arrow
                    if (!showCategories)
                      Focus(
                        onFocusChange: (hasFocus) {
                          setState(() {
                            isBackFocused = hasFocus;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: isBackFocused
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: isBackFocused
                                      ? Colors.black
                                      : Colors.amber,
                                  size: 30,
                                ),
                                onPressed: () {
                                  ref
                                      .read(showCategoriesProvider.notifier)
                                      .state = true;
                                  ref
                                      .read(canFocusDishListProvider.notifier)
                                      .state = false;
                                  Future.delayed(
                                      const Duration(milliseconds: 50), () {
                                    categoryFocusNodes[
                                            ref.read(selectedCategoryProvider)]
                                        .requestFocus();
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 100),
                          ],
                        ),
                      ),

                    // Category List
                    if (showCategories)
                       Expanded(
                        flex: 2,
                        child: CategoryList(
                          categories: categories,
                          categoryFocusNodes: categoryFocusNodes,
                          dishFocusNodes: dishFocusNodes,
                        ),
                      ),

                    // Dish List
                    Expanded(
                      flex: showCategories ? 2 : 3,
                      // take more space if category is hidden
                      child: DishList(
                          dishes: filteredDishes,
                          dishFocusNodes: dishFocusNodes),
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
