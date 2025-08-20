import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/utils/constants.dart';

import '../data/models/food_item.dart';
import '../data/services/api_service.dart';

class MealsNotifier extends StateNotifier<List<FoodItem>> {
  MealsNotifier(this._api) : super([]) {
    loadMeals();
  }

  final ApiService _api;

  Future<void> loadMeals() async {
    final meals = await _api.getFoodDetails(kSerialNumber, kPropertyId);
    state = meals;
  }

  void updateDishCookingInstruction(int dishId, String newInstruction) {
    state = state.map((category) {
      // Update recursively for nested subcategories
      FoodItem updateCategory(FoodItem cat) {
        final updatedDishes = cat.dishes?.map((dish) {
          if (dish.id == dishId) {
            return dish.copyWith(cooking_request: newInstruction);
          }
          return dish;
        }).toList();

        final updatedSub = cat.sub_categories?.map(updateCategory).toList();

        return cat.copyWith(
          dishes: updatedDishes,
          sub_categories: updatedSub,
        );
      }

      return updateCategory(category);
    }).toList();
  }
}
