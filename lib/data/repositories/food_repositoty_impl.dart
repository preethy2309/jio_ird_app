import '../../main.dart';
import '../datasources/local_json_loader.dart';
import '../datasources/remote_api_client.dart';
import '../models/food_item.dart';
import 'food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final RemoteApiClient apiClient;
  final LocalJsonLoader jsonLoader;

  FoodRepositoryImpl(this.apiClient, this.jsonLoader);

  @override
  Future<List<FoodItem>> fetchMeals(String serial, String propertyId) async {
    if (currentEnv == Environment.dev) {
      return await jsonLoader.loadMealsFromAssets();
    } else {
      return await apiClient.getMeals(
          serialNum: serial, propertyId: propertyId);
    }
  }
}
