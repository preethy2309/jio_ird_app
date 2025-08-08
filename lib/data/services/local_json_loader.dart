import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/food_item.dart';

class LocalJsonLoader {
  Future<List<FoodItem>> loadMealsFromAssets() async {
    final jsonString = await rootBundle.loadString('assets/dummy/meals.json');
    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => FoodItem.fromJson(e)).toList();
  }
}