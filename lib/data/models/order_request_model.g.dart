// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DishOrderItem _$DishOrderItemFromJson(Map<String, dynamic> json) =>
    DishOrderItem(
      id: json['id'] as String,
      quantity: json['quantity'] as String,
      status: json['status'] as String,
      cooking_request: json['cooking_request'] as String? ?? "",
    );

Map<String, dynamic> _$DishOrderItemToJson(DishOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'status': instance.status,
      'cooking_request': instance.cooking_request,
    };

CreateOrderRequest _$CreateOrderRequestFromJson(Map<String, dynamic> json) =>
    CreateOrderRequest(
      dishDetails: (json['dish_details'] as List<dynamic>)
          .map((e) => DishOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      guest_id: json['guest_id'] as String,
      guest_name: json['guest_name'] as String,
      room_no: json['room_no'] as String,
      serialNum: json['serial_Num'] as String,
    );

Map<String, dynamic> _$CreateOrderRequestToJson(CreateOrderRequest instance) =>
    <String, dynamic>{
      'dish_details': instance.dishDetails,
      'guest_id': instance.guest_id,
      'guest_name': instance.guest_name,
      'room_no': instance.room_no,
      'serial_Num': instance.serialNum,
    };
