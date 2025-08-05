import 'package:json_annotation/json_annotation.dart';
part 'dish_model.g.dart';

@JsonSerializable()
class Dish {
  @JsonKey(name: 'dish_id')
  final int id;
  @JsonKey(name: 'dish_name')
  final String name;
  final String description;
  final String dish_type;
  final String dish_price;
  final String dish_image;
  final String? file_type;
  final String? file_name;
  final String? cooking_request;
  @JsonKey(name: 'dish_qty')
  final int? quantity;

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.dish_type,
    required this.dish_price,
    required this.dish_image,
    this.file_type,
    this.file_name,
    this.cooking_request,
    this.quantity,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
  Map<String, dynamic> toJson() => _$DishToJson(this);
}