import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../notifiers/cart_notifier.dart';
import '../../../providers/focus_provider.dart';
import '../../../providers/state_provider.dart';
import '../../widgets/cart/bill_summary.dart';
import '../../widgets/cart/cart_empty.dart';
import '../../widgets/cart/cart_item_list.dart';
import '../../widgets/cart/order_placed.dart';
import '../../widgets/cart/tab_switcher.dart';
import '../../widgets/my_orders/my_order_list.dart';
import '../base/base_screen.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BaseScreen(
      title: "Cart",
      child: SafeArea(
        child: Column(
          children: [
            TabSwitcher(),
            SizedBox(height: 20),
            Expanded(child: _CartContent()),
          ],
        ),
      ),
    );
  }
}

class _CartContent extends ConsumerWidget {
  const _CartContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedCartTabProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child:
          selectedTab == CartTab.cart ? const _CartView() : const MyOrderList(),
    );
  }
}

class _CartView extends ConsumerWidget {
  const _CartView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderPlaced = ref.watch(orderPlacedProvider);
    final cartItems = ref.watch(itemQuantitiesProvider);

    if (orderPlaced) {
      return OrderPlaced(
        onTrackOrder: () {
          ref.read(selectedCartTabProvider.notifier).state = CartTab.orders;
          ref.read(myOrdersTabFocusNodeProvider).requestFocus();
          ref.read(orderPlacedProvider.notifier).state = false;
        },
      );
    }

    if (cartItems.isEmpty) {
      return const Center(child: EmptyCartScreen(title: "Empty Cart"));
    }

    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 4, child: CartItemsList()),
        SizedBox(width: 32),
        Expanded(flex: 3, child: BillSummaryScreen()),
      ],
    );
  }
}
