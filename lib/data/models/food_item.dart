import 'package:json_annotation/json_annotation.dart';
import 'dish_model.dart';
part 'food_item.g.dart';

@JsonSerializable()
class FoodItem {
  final int id;
  final String category_name;
  final String? ird_note;
  final List<FoodItem>? sub_categories;
  final List<Dish>? dishes;

  FoodItem({
    required this.id,
    required this.category_name,
    this.ird_note,
    this.sub_categories,
    this.dishes,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) => _$FoodItemFromJson(json);

  Map<String, dynamic> toJson() => _$FoodItemToJson(this);
}