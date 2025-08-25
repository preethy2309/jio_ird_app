// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusResponse _$OrderStatusResponseFromJson(Map<String, dynamic> json) =>
    OrderStatusResponse(
      order_id: _toInt(json['order_id']),
      guest_name: json['guest_name'] as String?,
      guest_id: json['guest_id'] as String?,
      room_no: json['room_no'] as String,
      display_id: _toString(json['display_id']),
      dish_details: (json['dish_details'] as List<dynamic>)
          .map((e) => OrderDishDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderStatusResponseToJson(
        OrderStatusResponse instance) =>
    <String, dynamic>{
      'order_id': instance.order_id,
      'guest_name': instance.guest_name,
      'guest_id': instance.guest_id,
      'room_no': instance.room_no,
      'display_id': instance.display_id,
      'dish_details': instance.dish_details,
    };

OrderDishDetail _$OrderDishDetailFromJson(Map<String, dynamic> json) =>
    OrderDishDetail(
      name: json['name'] as String,
      quantity: _toInt(json['quantity']),
      price: _toString(json['price']),
      id: _toInt(json['id']),
      dish_type: json['dish_type'] as String,
      status: json['status'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$OrderDishDetailToJson(OrderDishDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'id': instance.id,
      'dish_type': instance.dish_type,
      'status': instance.status,
      'image': instance.image,
    };
