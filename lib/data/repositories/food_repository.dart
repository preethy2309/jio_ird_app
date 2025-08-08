import '../../data/models/food_item.dart';
import '../models/order_request.dart';
import '../models/order_status_response.dart';

abstract class FoodRepository {
  Future<List<FoodItem>> fetchMeals(String serial, String propertyId);
  Future<Map<String, dynamic>> createOrder(OrderRequest order);
  Future<List<OrderStatusResponse>> getOrderStatus(String guestId, String serial);
}