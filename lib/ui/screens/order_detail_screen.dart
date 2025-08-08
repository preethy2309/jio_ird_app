import 'package:flutter/material.dart';
import 'package:jio_ird/ui/widgets/menu/bottom_layout.dart';

import '../widgets/my_orders/order_card.dart';
import '../widgets/my_orders/order_info.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Text(
              "Room No. 132",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),

            // Order details row
            const OrderInfo(
                orderNo: "000000", billDetails: "billDetails", toPay: "100"),
            const SizedBox(height: 30),

            // Orders list
            Expanded(
              child: ListView(
                children: const [
                  OrderCard(
                    dishName: "Paneer Butter Masala",
                    qty: 1,
                    price: 110,
                    isSelected: true,
                    status: "Order Placed",
                  ),
                  OrderCard(
                    dishName: "Stuffed Portobello Mushrooms",
                    qty: 1,
                    price: 125,
                    status: "Order Placed",
                  ),
                  OrderCard(
                    dishName: "Portobello Veg Burger",
                    qty: 1,
                    price: 125,
                    status: "Served",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomLayout(),
    );
  }
}
