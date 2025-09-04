import 'package:flutter/material.dart';
import '../../../../data/models/dish_model.dart';
import '../../../../data/models/food_item.dart';
import 'category_list/category_list.dart';
import 'dish_list/dish_list.dart';
import 'dish_detail/dish_detail.dart';
import 'no_dishes_view.dart';

class CategoryDishView extends StatelessWidget {
  final List<FoodItem> categories;
  final FoodItem selectedCat;
  final List<Dish> filteredDishes;
  final int focusedDish;

  const CategoryDishView({
    super.key,
    required this.categories,
    required this.selectedCat,
    required this.filteredDishes,
    required this.focusedDish,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 202,
          child: CategoryList(categories: categories),
        ),
        const SizedBox(width: 16),
        if (filteredDishes.isEmpty)
          const NoDishesView()
        else ...[
          SizedBox(width: 240, child: DishList(dishes: filteredDishes)),
          Expanded(
            child: DishDetail(
              dish: (focusedDish >= 0 && focusedDish < filteredDishes.length)
                  ? filteredDishes[focusedDish]
                  : filteredDishes.first,
              categoryName: selectedCat.categoryName ?? '',
              itemCount: filteredDishes.length,
            ),
          ),
        ],
      ],
    );
  }
}
