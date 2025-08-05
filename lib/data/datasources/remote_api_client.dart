import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../models/food_item.dart';
part 'remote_api_client.g.dart';

@RestApi(baseUrl: "https://sit.jhes.cms.jio.com/jiohotels")
abstract class RemoteApiClient {
  factory RemoteApiClient(Dio dio, {String baseUrl}) = _RemoteApiClient;

  @GET("/v2/order/get_ird_details")
  Future<List<FoodItem>> getMeals({
    @Query("serial_num") required String serialNum,
    @Query("property_id") required String propertyId,
  });
}