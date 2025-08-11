import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/screens/base_screen.dart';

import '../../providers/state_provider.dart';
import '../widgets/cart/cart_item_list.dart';
import '../widgets/cart/delivery_info_panel.dart';
import '../widgets/cart/tab_switcher.dart';
import '../widgets/my_orders/my_order_list.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedCartTabProvider);

    return BaseScreen(
      title: "Cart",
      description: "Room No: 204",
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            const TabSwitcher(),

            const SizedBox(height: 20),

            // Switch content based on selected tab
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: selectedTab == CartTab.cart
                    ? const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: CartItemsList(),
                          ),
                          SizedBox(width: 32),
                          Expanded(
                            flex: 3,
                            child: DeliveryInfoPanel(),
                          ),
                        ],
                      )
                    : const MyOrderList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
