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
  final String? allergies;
  final String? contains;
  String? cooking_request;
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
    this.allergies,
    this.contains,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
  Map<String, dynamic> toJson() => _$DishToJson(this);

  // copyWith function
  Dish copyWith({
    int? id,
    String? name,
    String? description,
    String? dish_type,
    String? dish_price,
    String? dish_image,
    String? file_type,
    String? file_name,
    String? allergies,
    String? contains,
    String? cooking_request,
    int? quantity,
  }) {
    return Dish(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      dish_type: dish_type ?? this.dish_type,
      dish_price: dish_price ?? this.dish_price,
      dish_image: dish_image ?? this.dish_image,
      file_type: file_type ?? this.file_type,
      file_name: file_name ?? this.file_name,
      allergies: allergies ?? this.allergies,
      contains: contains ?? this.contains,
      cooking_request: cooking_request ?? this.cooking_request,
      quantity: quantity ?? this.quantity,
    );
  }
}
