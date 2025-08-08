import 'package:flutter/material.dart';
import 'package:jio_ird/ui/widgets/menu/menu_top_bar/profile_icon.dart';

import '../widgets/cart/cart_item_list.dart';
import '../widgets/cart/delivery_info_panel.dart';
import '../widgets/cart/tab_switcher.dart';
import '../widgets/header.dart';
import '../widgets/menu/bottom_layout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Header(
                    title: "Cart",
                    description: "Room No: 1234",
                  ),
                  Spacer(),
                  ProfileIcon()
                ],
              ),
            ),
            SizedBox(height: 2),

            // Tabs
            TabSwitcher(),

            SizedBox(height: 20),

            // Main Body
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart Items List
                    Expanded(
                      flex: 4,
                      child: CartItemsList(),
                    ),
                    SizedBox(width: 32),
                    // Delivery Info
                    Expanded(
                      flex: 3,
                      child: DeliveryInfoPanel(),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            // Bottom Bar
            BottomLayout(),
          ],
        ),
      ),
    );
  }
}
