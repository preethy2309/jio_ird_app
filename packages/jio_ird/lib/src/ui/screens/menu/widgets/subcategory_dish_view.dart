import 'package:flutter/material.dart';
import '../../../../data/models/dish_model.dart';
import '../../../../data/models/food_item.dart';
import 'dish_detail/dish_detail.dart';
import 'dish_list/dish_list.dart';
import 'sub_category_list/sub_category_list.dart';
import 'no_dishes_view.dart';

class SubCategoryDishView extends StatelessWidget {
  final FoodItem selectedCat;
  final List<Dish> filteredDishes;
  final int focusedDish;
  final int focusedSubCategory;

  const SubCategoryDishView({
    super.key,
    required this.selectedCat,
    required this.filteredDishes,
    required this.focusedDish,
    required this.focusedSubCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 202,
          child: SubCategoryList(subCategories: selectedCat.subCategories!),
        ),
        const SizedBox(width: 16),
        if (filteredDishes.isEmpty)
          const NoDishesView()
        else ...[
          SizedBox(width: 280, child: DishList(dishes: filteredDishes)),
          Expanded(
            child: DishDetail(
              dish: (focusedDish >= 0 && focusedDish < filteredDishes.length)
                  ? filteredDishes[focusedDish]
                  : filteredDishes.first,
              categoryName: selectedCat
                  .subCategories![focusedSubCategory].categoryName ??
                  '',
              itemCount: filteredDishes.length,
            ),
          ),
        ],
      ],
    );
  }
}