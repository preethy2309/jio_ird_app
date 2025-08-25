import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/food_item.dart';
import '../models/order_status_response.dart';

class LocalJsonLoader {
  Future<List<FoodItem>> loadMealsFromAssets() async {
    final jsonString = await rootBundle.loadString('assets/dummy/meals.json');
    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => FoodItem.fromJson(e)).toList();
  }

  Future<List<OrderStatusResponse>> loadOrdersFromAssets() async {
    final jsonString =
        await rootBundle.loadString('assets/dummy/order_status.json');
    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => OrderStatusResponse.fromJson(e)).toList();
  }
}
