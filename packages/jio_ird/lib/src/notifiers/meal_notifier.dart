import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/food_item.dart';
import '../data/services/api_service.dart';
import '../utils/constants.dart';

class MealsNotifier extends StateNotifier<List<FoodItem>> {
  MealsNotifier(this._api) : super([]) {
    loadMeals();
  }

  final ApiService _api;

  Future<void> loadMeals() async {
    final meals = await _api.getFoodDetails(kSerialNumber, kPropertyId);
    final filteredMeals = meals.where((category) {
      category.sub_categories?.removeWhere(
          (subCat) => (subCat.dishes == null || subCat.dishes!.isEmpty));

      final hasValidSubCats = category.sub_categories != null &&
          category.sub_categories!.isNotEmpty;
      final hasItems = category.dishes != null && category.dishes!.isNotEmpty;

      return hasValidSubCats || hasItems;
    }).toList();

    state = filteredMeals;
  }

  void updateDishCookingInstruction(int dishId, String newInstruction) {
    state = state.map((category) {
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
