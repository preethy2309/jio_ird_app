import '../../data/models/food_item.dart';

abstract class FoodRepository {
  Future<List<FoodItem>> fetchMeals(String serial, String propertyId);
}