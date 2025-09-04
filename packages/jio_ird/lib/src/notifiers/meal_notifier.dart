import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/repository/data_repository.dart';

import '../data/models/food_item.dart';
import '../providers/data_repository_provider.dart';
import '../providers/external_providers.dart';

class MealsNotifier extends StateNotifier<List<FoodItem>> {
  final DataRepository repo;
  final String serialNum;
  final String propertyId;

  MealsNotifier(this.repo, this.serialNum, this.propertyId) : super([]) {
    loadMeals();
  }

  Future<void> loadMeals() async {
    try {
      final meals = await repo.fetchFoodDetails(serialNum, propertyId);
      state = _filterValidMeals(meals);
    } catch (e) {
      state = [];
    }
  }

  void updateDishCookingInstruction(int dishId, String newInstruction) {
    state = [
      for (final category in state)
        _updateCategoryWithInstruction(category, dishId, newInstruction),
    ];
  }

  List<FoodItem> _filterValidMeals(List<FoodItem> meals) {
    return [
      for (final category in meals)
        if (_hasValidContent(category)) _filterCategory(category),
    ];
  }

  bool _hasValidContent(FoodItem category) {
    final hasValidSubCats =
        category.subCategories?.any((sub) => sub.dishes?.isNotEmpty ?? false) ??
            false;
    final hasItems = category.dishes?.isNotEmpty ?? false;
    return hasValidSubCats || hasItems;
  }

  FoodItem _filterCategory(FoodItem category) {
    final filteredSub = category.subCategories
        ?.where((sub) => sub.dishes?.isNotEmpty ?? false)
        .map(_filterCategory)
        .toList();

    return category.copyWith(subCategories: filteredSub);
  }

  FoodItem _updateCategoryWithInstruction(
    FoodItem category,
    int dishId,
    String instruction,
  ) {
    final updatedDishes = category.dishes?.map((dish) {
      if (dish.id == dishId) {
        return dish.copyWith(cookingRequest: instruction);
      }
      return dish;
    }).toList();

    final updatedSub = category.subCategories
        ?.map((sub) => _updateCategoryWithInstruction(sub, dishId, instruction))
        .toList();

    return category.copyWith(
      dishes: updatedDishes,
      subCategories: updatedSub,
    );
  }
}

final mealsProvider =
    StateNotifierProvider<MealsNotifier, List<FoodItem>>((ref) {
  final repo = ref.read(dataRepositoryProvider);
  final serialNum = ref.read(serialNumberProvider);
  final propertyId = ref.read(guestDetailsProvider).propertyId;
  return MealsNotifier(repo, serialNum, propertyId);
});
