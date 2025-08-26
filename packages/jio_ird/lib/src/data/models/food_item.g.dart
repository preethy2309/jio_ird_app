// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) => FoodItem(
      id: (json['id'] as int?)?.toInt(),
      category_name: json['category_name'] as String,
      ird_note: json['ird_note'] as String?,
      sub_categories: (json['sub_categories'] as List<dynamic>?)
          ?.map((e) => FoodItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      dishes: (json['dishes'] as List<dynamic>?)
          ?.map((e) => Dish.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
      'id': instance.id,
      'category_name': instance.category_name,
      'ird_note': instance.ird_note,
      'sub_categories': instance.sub_categories,
      'dishes': instance.dishes,
    };
