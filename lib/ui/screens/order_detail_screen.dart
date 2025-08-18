import 'package:flutter/material.dart';
import 'package:jio_ird/ui/screens/base_screen.dart';
import 'package:jio_ird/ui/widgets/my_orders/order_card.dart';
import 'package:jio_ird/ui/widgets/my_orders/order_info.dart';

import '../../../data/models/order_status_response.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderStatusResponse order;

  OrderDetailScreen({
    super.key,
    required this.order,
  });

  final List<String> _statusOrder = [
    "placed",
    "accepted",
    "preparing",
    "served",
  ];

  int _getStepIndex(String? status) {
    if (status == null) return 0;
    return _statusOrder.indexOf(status.toLowerCase());
  }

  String _calculateTotal(List<OrderDishDetail> dishes) {
    double total = 0;
    for (var dish in dishes) {
      final price = (dish.price is num)
          ? (dish.price as num).toDouble()
          : double.tryParse(dish.price.toString()) ?? 0;
      total += price * dish.quantity;
    }
    return total.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "My Order",
      description: "Room No. 204",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderInfo(
              orderNo: order.order_id.toString(),
              billDetails: "${order.dish_details.length} Items",
              toPay: "₹ ${_calculateTotal(order.dish_details)}",
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: order.dish_details.length,
                itemBuilder: (context, index) {
                  final dish = order.dish_details[index];
                  final currentStep = _getStepIndex(dish.status);

                  final Map<String, Color> stepColors = {};
                  for (int i = 0; i < _statusOrder.length; i++) {
                    stepColors[_statusOrder[i]] =
                        (i <= currentStep) ? Colors.amber : Colors.grey;
                  }

                  return OrderCard(
                    dishName: dish.name ?? '',
                    qty: dish.quantity,
                    price: dish.price,
                    status: dish.status ?? '',
                    autoFocus: index == 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
