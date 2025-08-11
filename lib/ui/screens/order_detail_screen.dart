import 'package:flutter/material.dart';
import 'package:jio_ird/ui/widgets/menu/bottom_layout.dart';
import 'package:jio_ird/ui/widgets/my_orders/order_card.dart';
import 'package:jio_ird/ui/widgets/my_orders/order_info.dart';

import '../../../data/models/order_status_response.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderStatusResponse order;

  const OrderDetailScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total price from dish_details
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

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "My Order",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Room No. ${order.room_no ?? ''}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),

            // Order summary info
            OrderInfo(
              orderNo: order.order_id.toString(),
              billDetails: "${order.dish_details.length} Items",
              toPay: "₹ ${calculateTotal(order.dish_details)}",
            ),
            const SizedBox(height: 30),

            // Orders list
            Expanded(
              child: ListView.builder(
                itemCount: order.dish_details.length,
                itemBuilder: (context, index) {
                  final dish = order.dish_details[index];
                  return OrderCard(
                    dishName: dish.name ?? '',
                    qty: dish.quantity,
                    price: dish.price,
                    status: dish.status ?? '',
                    isSelected: false, // set based on your selection logic
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomLayout(),
    );
  }
}
