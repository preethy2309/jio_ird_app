import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodel/meals_notifier.dart';
import '../widgets/bottom_layout.dart';
import '../widgets/category_list.dart';
import '../widgets/dish_detail.dart';
import '../widgets/dish_list.dart';
import '../widgets/menu_top_bar.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  final List<FocusNode> categoryFocusNodes = [];
  final List<FocusNode> dishFocusNodes = [];

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
                    Expanded(
                      flex: 2,
                      child: CategoryList(
                        categories: categories,
                        categoryFocusNodes: categoryFocusNodes,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: DishList(
                        dishes: filteredDishes,
                        dishFocusNodes: dishFocusNodes,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: filteredDishes.isNotEmpty
                          ? DishDetail(dish: filteredDishes[focusedDish])
                          : const Center(
                              child: Text('No dishes',
                                  style: TextStyle(color: Colors.white)),
                            ),
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
