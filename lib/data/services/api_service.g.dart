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
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'serial_num': serialNum};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v1/generate_secret_token',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
    );
    final value = TokenResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<FoodItem>> getFoodDetails(serialNum, propertyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'serial_num': serialNum,
      'property_id': propertyId
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v2/order/get_ird_details',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
    );
    var value = _result.data!
        .map((dynamic i) => FoodItem.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Map<String, dynamic>> createOrder(order) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = order.toJson();
    final _result = await _dio.fetch<Map<String, dynamic>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v2/create_order',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
    );
    final value = _result.data!;
    return value;
  }

  @override
  Future<List<OrderStatusResponse>> getOrderStatus(guestId, serialNum) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'guest_id': guestId,
      'serial_num': serialNum
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
        _dio.options,
        '/v2/order_status',
        queryParameters: queryParameters,
        data: _data,
      )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
    );
    var value = _result.data!
        .map((dynamic i) =>
        OrderStatusResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
