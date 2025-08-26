import 'package:json_annotation/json_annotation.dart';

import 'dish_model.dart';

part 'food_item.g.dart';

@JsonSerializable()
class FoodItem {
  final int? id;
  final String? category_name;
  final String? ird_note;
  final List<FoodItem>? sub_categories;
  final List<Dish>? dishes;

  FoodItem({
    this.id,
    this.category_name,
    this.ird_note,
    this.sub_categories,
    this.dishes,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);

  Map<String, dynamic> toJson() => _$FoodItemToJson(this);

  FoodItem copyWith({
    int? id,
    String? category_name,
    String? ird_note,
    List<FoodItem>? sub_categories,
    List<Dish>? dishes,
  }) {
    return FoodItem(
      id: id ?? this.id,
      category_name: category_name ?? this.category_name,
      ird_note: ird_note ?? this.ird_note,
      sub_categories: sub_categories ?? this.sub_categories,
      dishes: dishes ?? this.dishes,
    );
  }
}
