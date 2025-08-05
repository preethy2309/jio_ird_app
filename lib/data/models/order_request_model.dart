import 'package:json_annotation/json_annotation.dart';

part 'order_request_model.g.dart';

@JsonSerializable()
class DishOrderItem {
  final String id;
  final String quantity;
  final String status;
  final String cooking_request;

  DishOrderItem({
    required this.id,
    required this.quantity,
    required this.status,
    this.cooking_request = "",
  });

  factory DishOrderItem.fromJson(Map<String, dynamic> json) => _$DishOrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$DishOrderItemToJson(this);
}

@JsonSerializable()
class CreateOrderRequest {
  @JsonKey(name: "dish_details")
  final List<DishOrderItem> dishDetails;
  final String guest_id;
  final String guest_name;
  final String room_no;
  @JsonKey(name: "serial_Num")
  final String serialNum;

  CreateOrderRequest({
    required this.dishDetails,
    required this.guest_id,
    required this.guest_name,
    required this.room_no,
    required this.serialNum,
  });

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) => _$CreateOrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderRequestToJson(this);
}