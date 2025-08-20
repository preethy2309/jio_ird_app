import 'package:jio_ird/data/models/order_request.dart';
import 'package:jio_ird/data/models/order_status_response.dart';

import '../../main.dart';
import '../models/food_item.dart';
import '../services/api_service.dart';
import '../services/local_json_loader.dart';
import 'food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final ApiService apiClient;
  final LocalJsonLoader jsonLoader;

  FoodRepositoryImpl(this.apiClient, this.jsonLoader);

  @override
  Future<List<FoodItem>> fetchMeals(String serial, String propertyId) async {
    if (currentEnv == Environment.dev) {
      return await jsonLoader.loadMealsFromAssets();
    } else {
      return await apiClient.getFoodDetails(serial, propertyId);
    }
  }

  @override
  Future<Map<String, dynamic>> createOrder(OrderRequest order) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  Future<List<OrderStatusResponse>> getOrderStatus(
      String guestId, String serial) async {
    if (currentEnv == Environment.dev) {
      return await jsonLoader.loadOrdersFromAssets();
    } else {
      return await apiClient.getOrderStatus(guestId, serial);
    }
  }
}
