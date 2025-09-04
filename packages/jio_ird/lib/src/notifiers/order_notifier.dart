import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/providers/external_providers.dart';

import '../data/models/dish_with_quantity.dart';
import '../notifiers/cart_notifier.dart';
import '../providers/data_repository_provider.dart';
import '../providers/state_provider.dart';
import '../repository/data_repository.dart';
import '../utils/util.dart';

class OrderNotifier extends AutoDisposeNotifier<AsyncValue<String>> {
  late final DataRepository _repo;
  late final String _serialNum;
  late final String _roomNo;

  @override
  AsyncValue<String> build() {
    _repo = ref.read(dataRepositoryProvider);
    _serialNum = ref.watch(serialNumberProvider);
    _roomNo = ref.watch(guestDetailsProvider).roomNo;

    return const AsyncValue.data("");
  }

  Future<void> placeOrder(List<DishWithQuantity> items) async {
    if (items.isEmpty) {
      state = const AsyncValue.error("Cart is empty", StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();

    final orderRequest =
    createOrderRequestFromDishWithQuantity(items, _serialNum, _roomNo);

    try {
      final response = await _repo.placeOrder(orderRequest);

      final status = response['status'] as int?;
      final message = response['response'] as String? ?? "Unknown response";

      if (status == 200) {
        _onOrderSuccess(message);
      } else {
        state = AsyncValue.error(
          "Failed to place order: $message",
          StackTrace.current,
        );
      }
    } catch (e, st) {
      state = AsyncValue.error("Unexpected error: $e", st);
    }
  }

  void _onOrderSuccess(String message) {
    ref.read(itemQuantitiesProvider.notifier).clearCart();
    ref.read(orderPlacedProvider.notifier).state = true;
    state = AsyncValue.data(message);
  }
}

final orderNotifierProvider =
AutoDisposeNotifierProvider<OrderNotifier, AsyncValue<String>>(
  OrderNotifier.new,
);
