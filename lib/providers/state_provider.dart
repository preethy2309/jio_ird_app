import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/data/models/order_status_response.dart';

import '../config/env_config.dart';
import '../data/models/food_item.dart';
import '../data/repositories/food_repository.dart';
import '../data/repositories/food_repositoty_impl.dart';
import '../data/services/api_service.dart';
import '../data/services/local_json_loader.dart';

enum CartTab { cart, orders }

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  final dio = Dio();
  final client = ApiService(dio, baseUrl: EnvConfig.baseUrl);
  final loader = LocalJsonLoader();
  return FoodRepositoryImpl(client, loader);
});

final mealsProvider = FutureProvider.autoDispose<List<FoodItem>>((ref) async {
  final repo = ref.watch(foodRepositoryProvider);
  return repo.fetchMeals("RDTSBHF00004205", "12345");
});

final orderStatusProvider =
    FutureProvider.autoDispose<List<OrderStatusResponse>>((ref) async {
  final repo = ref.watch(foodRepositoryProvider);
  return repo.getOrderStatus("RDTSBHF00004205", "12345");
});

/// Toggle for showing only Veg items
final vegOnlyProvider = StateProvider<bool>((ref) => false);

/// Currently selected category index
final selectedCategoryProvider = StateProvider<int>((ref) => 0);

/// Currently selected dish index (inside the selected category)
final selectedDishProvider = StateProvider<int>((ref) => -1);

/// Currently focused dish index (inside the selected category)
final focusedDishProvider = StateProvider<int>((ref) => 0);

/// Toggle for showing/hiding categories
final showCategoriesProvider = StateProvider<bool>((ref) => true);

/// Map of dishId to quantity added
final itemQuantitiesProvider = StateProvider<Map<int, int>>((ref) => {});

final canFocusDishListProvider = StateProvider<bool>((ref) => false);

final hasNavigatedToDishesProvider = StateProvider<bool>((ref) => false);

final selectedCartTabProvider = StateProvider<CartTab>((ref) => CartTab.cart);
