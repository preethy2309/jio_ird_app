// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      dish_details: (json['dish_details'] as List<dynamic>)
          .map((e) => OrderDish.fromJson(e as Map<String, dynamic>))
          .toList(),
      guest_id: json['guest_id'] as String,
      guest_name: json['guest_name'] as String,
      room_no: json['room_no'] as String,
      serial_Num: json['serial_Num'] as String,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'dish_details': instance.dish_details,
      'guest_id': instance.guest_id,
      'guest_name': instance.guest_name,
      'room_no': instance.room_no,
      'serial_Num': instance.serial_Num,
    };

OrderDish _$OrderDishFromJson(Map<String, dynamic> json) => OrderDish(
      cooking_request: json['cooking_request'] as String,
      id: json['id'] as int,
      quantity: json['quantity'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$OrderDishToJson(OrderDish instance) => <String, dynamic>{
      'cooking_request': instance.cooking_request,
      'id': instance.id,
      'quantity': instance.quantity,
      'status': instance.status,
    };
