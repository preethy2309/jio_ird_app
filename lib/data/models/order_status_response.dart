import 'package:json_annotation/json_annotation.dart';
part 'order_status_response.g.dart';

@JsonSerializable()
class OrderStatusResponse {
  final int order_id;
  final String guest_name;
  final String guest_id;
  final String room_no;
  final String display_id;
  final List<OrderDishDetail> dish_details;

  OrderStatusResponse({
    required this.order_id,
    required this.guest_name,
    required this.guest_id,
    required this.room_no,
    required this.display_id,
    required this.dish_details,
  });

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusResponseToJson(this);
}

@JsonSerializable()
class OrderDishDetail {
  final String name;
  final int quantity;
  final String price;
  final int id;
  final String dish_type;
  final String status;
  final String image;

  OrderDishDetail({
    required this.name,
    required this.quantity,
    required this.price,
    required this.id,
    required this.dish_type,
    required this.status,
    required this.image,
  });

  factory OrderDishDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDishDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDishDetailToJson(this);
}
