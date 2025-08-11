import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/widgets/my_orders/order_info.dart';

import '../../../data/models/order_status_response.dart';
import '../../../providers/state_provider.dart';

class MyOrderList extends ConsumerWidget {
  const MyOrderList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderStatusAsync = ref.watch(orderStatusProvider);

    return orderStatusAsync.when(
      data: (orders) {
        if (orders.isEmpty) {
          return const Center(child: Text('No orders found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            final itemCount = order.dish_details.fold<int>(
              0,
                  (sum, dish) => sum + int.tryParse(dish.quantity.toString())!,
            );
            final isActive = false; // TODO: implement active order logic

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _orderTile(
                orderNo: order.order_id.toString(),
                billDetails: '$itemCount Items',
                toPay: '₹ ${calculateTotal(order.dish_details)}',
                isActive: isActive,
                buttonText: 'Track Order',
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  String calculateTotal(List<OrderDishDetail> dishes) {
    double total = 0;
    for (var dish in dishes) {
      final price = (dish.price is num)
          ? (dish.price as num).toDouble()
          : double.tryParse(dish.price.toString()) ?? 0;
      total += price * dish.quantity;
    }
    return total.toStringAsFixed(0);
  }

  Widget _orderTile({
    required String orderNo,
    required String billDetails,
    required String toPay,
    bool isActive = false,
    required String buttonText,
    bool isButton = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.amber : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 100),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OrderInfo(orderNo: orderNo, billDetails: billDetails, toPay: toPay),
          isButton
              ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              // TODO: Implement order tracking action
            },
            child: Text(buttonText),
          )
              : Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
