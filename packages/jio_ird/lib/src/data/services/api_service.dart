import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/food_item.dart';
import '../models/order_request.dart';
import '../models/order_status_response.dart';
import '../models/token_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/v1/generate_secret_token')
  Future<TokenResponse> generateToken(
    @Query('serial_num') String serialNum,
  );

  @GET('/v2/order/get_ird_details')
  Future<List<FoodItem>> getFoodDetails(
    @Query('serial_num') String serialNum,
    @Query('property_id') String propertyId,
  );

  @POST('/v2/create_order')
  Future<Map<String, dynamic>> createOrder(
    @Body() OrderRequest order,
  );

  @POST('/v2/order_status')
  Future<List<OrderStatusResponse>> getOrderStatus(
    @Query('serial_Num') String serialNum,
  );
}
