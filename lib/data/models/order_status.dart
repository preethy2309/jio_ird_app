import 'package:json_annotation/json_annotation.dart';
part 'order_status.g.dart';

@JsonSerializable()
class OrderStatusResponse {
  final String status;

  OrderStatusResponse({required this.status});
  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) => _$OrderStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusResponseToJson(this);
}
