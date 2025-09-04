import 'package:flutter/material.dart';
import '../../../../data/models/dish_model.dart';
import '../../../../data/models/food_item.dart';
import 'category_list/category_list.dart';
import 'dish_detail/dish_detail.dart';
import 'sub_category_list/sub_categories_with_image.dart';
import 'no_dishes_view.dart';

class CategorySubCategoryView extends StatelessWidget {
  final List<FoodItem> categories;
  final FoodItem selectedCat;
  final List<Dish> filteredDishes;
  final int focusedDish;

  const CategorySubCategoryView({
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
        SizedBox(width: 202, child: CategoryList(categories: categories)),
        const SizedBox(width: 16),
        SizedBox(
          width: 240,
          child: SubCategoriesWithImage(subCategories: selectedCat.subCategories!),
        ),
        if (filteredDishes.isEmpty)
          const NoDishesView()
        else
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
    );
  }
}