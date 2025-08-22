// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dish _$DishFromJson(Map<String, dynamic> json) => Dish(
      id: (json['dish_id'] as num).toInt(),
      name: json['dish_name'] as String,
      description: json['description'] as String,
      dish_type: json['dish_type'] as String,
      dish_price: json['dish_price'] as String,
      dish_image: json['dish_image'] as String?,
      file_type: json['file_type'] as String?,
      file_name: json['file_name'] as String?,
      cooking_request: json['cooking_request'] as String?,
      quantity: (json['dish_qty'] as num?)?.toInt(),
      allergies: json['allergies'] as String?,
      contains: json['contains'] as String?,
    );

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'dish_id': instance.id,
      'dish_name': instance.name,
      'description': instance.description,
      'dish_type': instance.dish_type,
      'dish_price': instance.dish_price,
      'dish_image': instance.dish_image,
      'file_type': instance.file_type,
      'file_name': instance.file_name,
      'allergies': instance.allergies,
      'contains': instance.contains,
      'cooking_request': instance.cooking_request,
      'dish_qty': instance.quantity,
    };
