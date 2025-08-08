import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  final List<OrderDish> dish_details;
  final String guest_id;
  final String guest_name;
  final String room_no;
  final String serial_Num;

  OrderRequest({
    required this.dish_details,
    required this.guest_id,
    required this.guest_name,
    required this.room_no,
    required this.serial_Num,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}

@JsonSerializable()
class OrderDish {
  final String cooking_request;
  final String id;
  final String quantity;
  final String status;

  OrderDish({
    required this.cooking_request,
    required this.id,
    required this.quantity,
    required this.status,
  });

  factory OrderDish.fromJson(Map<String, dynamic> json) =>
      _$OrderDishFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDishToJson(this);
}
