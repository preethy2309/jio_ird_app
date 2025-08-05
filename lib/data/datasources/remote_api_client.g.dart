// GENERATED CODE - MANUALLY WRITTEN

part of 'remote_api_client.dart';

class _RemoteApiClient implements RemoteApiClient {
  _RemoteApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://sit.jhes.cms.jio.com/jiohotels';
  }

  final Dio _dio;
  String? baseUrl;

  @override
  Future<List<FoodItem>> getMeals({
    required String serialNum,
    required String propertyId,
  }) async {
    final queryParams = <String, dynamic>{
      'serial_num': serialNum,
      'property_id': propertyId,
    };

    final result = await _dio.get<List<dynamic>>(
      '/v2/order/get_ird_details',
      queryParameters: queryParams,
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    return result.data!
        .map((json) => FoodItem.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
