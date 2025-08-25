// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://devices.cms.jio.com/jiohotels/';
  }

  final Dio _dio;
  String? baseUrl;

  @override
  Future<TokenResponse> generateToken(serialNum) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'serial_num': serialNum};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
      Options(method: 'POST', headers: headers, extra: extra)
          .compose(
            _dio.options,
            '/v1/generate_secret_token',
            queryParameters: queryParameters,
            data: data,
          )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
    );
    final value = TokenResponse.fromJson(result.data!);
    return value;
  }

  @override
  Future<List<FoodItem>> getFoodDetails(serialNum, propertyId) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'serial_num': serialNum,
      'property_id': propertyId
    };
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<List<dynamic>>(
      Options(method: 'GET', headers: headers, extra: extra)
          .compose(
            _dio.options,
            '/v2/order/get_ird_details',
            queryParameters: queryParameters,
            data: data,
          )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
    );
    var value = result.data!
        .map((dynamic i) => FoodItem.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Map<String, dynamic>> createOrder(order) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = order.toJson();
    final result = await _dio.fetch<Map<String, dynamic>>(
      Options(method: 'POST', headers: headers, extra: extra)
          .compose(
            _dio.options,
            '/v2/create_order',
            queryParameters: queryParameters,
            data: data,
          )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
    );
    final value = result.data!;
    return value;
  }

  @override
  Future<List<OrderStatusResponse>> getOrderStatus(String serialNum) async {
    const extra = <String, dynamic>{};

    final queryParameters = <String, dynamic>{
      'serial_Num': serialNum,
    };

    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};

    final result = await _dio.fetch<List<dynamic>>(
      Options(method: 'POST', headers: headers, extra: extra)
          .compose(
            _dio.options,
            '/v2/order_status',
            queryParameters: queryParameters,
            data: data,
          )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
    );

    var value = result.data!
        .map((dynamic i) =>
            OrderStatusResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
