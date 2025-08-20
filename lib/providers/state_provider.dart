import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/data/models/order_status_response.dart';
import 'package:jio_ird/utils/constants.dart';

import '../data/models/food_item.dart';
import '../notifiers/meal_notifier.dart';
import 'api_service_provider.dart';

enum CartTab { cart, orders }

final mealsProvider =
    StateNotifierProvider<MealsNotifier, List<FoodItem>>((ref) {
  final api = ref.read(apiServiceProvider);
  return MealsNotifier(api);
});

final orderStatusProvider =
    FutureProvider<List<OrderStatusResponse>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.getOrderStatus(kPropertyId, kSerialNumber);
});

/// Toggle for showing only Veg items
final vegOnlyProvider = StateProvider<bool>((ref) => false);

/// Currently selected category index
final selectedCategoryProvider = StateProvider<int>((ref) => 0);

/// Currently selected dish index (inside the selected category)
final selectedDishProvider = StateProvider<int>((ref) => -1);

/// Currently focused dish index (inside the selected category)
final focusedDishProvider = StateProvider<int>((ref) => -1);

/// Toggle for showing/hiding categories
final showCategoriesProvider = StateProvider<bool>((ref) => true);

final selectedCartTabProvider = StateProvider<CartTab>((ref) => CartTab.cart);

final orderPlacedProvider = StateProvider<bool>((ref) => false);
