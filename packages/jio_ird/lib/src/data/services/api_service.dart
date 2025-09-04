import 'package:dio/dio.dart';
import '../models/food_item.dart';
import '../models/order_request.dart';
import '../models/order_status_response.dart';
import '../models/token_response.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  Future<TokenResponse> generateToken(String serialNum) async {
    final response = await _dio.post(
      "/v1/generate_secret_token",
      queryParameters: {"serial_num": serialNum},
    );
    return TokenResponse.fromJson(response.data);
  }

  Future<List<FoodItem>> getFoodDetails(String serialNum, String propertyId) async {
    final response = await _dio.get(
      "/v2/order/get_ird_details",
      queryParameters: {"serial_num": serialNum, "property_id": propertyId},
    );
    return (response.data as List)
        .map((e) => FoodItem.fromJson(e))
        .toList();
  }

  Future<Map<String, dynamic>> createOrder(OrderRequest order) async {
    final response = await _dio.post(
      "/v2/create_order",
      data: order.toJson(),
    );
    return response.data;
  }

  Future<List<OrderStatusResponse>> getOrderStatus(String serialNum) async {
    final response = await _dio.post(
      "/v2/order_status",
      queryParameters: {"serial_Num": serialNum},
    );
    return (response.data as List)
        .map((e) => OrderStatusResponse.fromJson(e))
        .toList();
  }
}
