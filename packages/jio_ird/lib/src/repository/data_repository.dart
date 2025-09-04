import '../data/models/food_item.dart';
import '../data/models/order_request.dart';
import '../data/models/order_status_response.dart';
import '../data/models/token_response.dart';
import '../data/services/api_service.dart';

class DataRepository {
  final ApiService api;

  DataRepository(this.api);

  Future<TokenResponse> getToken(String serialNum) =>
      api.generateToken(serialNum);

  Future<List<FoodItem>> fetchFoodDetails(
          String serialNum, String propertyId) =>
      api.getFoodDetails(serialNum, propertyId);

  Future<Map<String, dynamic>> placeOrder(OrderRequest order) =>
      api.createOrder(order);

  Future<List<OrderStatusResponse>> checkOrderStatus(String serialNum) =>
      api.getOrderStatus(serialNum);
}
