import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/dish_with_quantity.dart';
import '../../../providers/cart_provider.dart';
import 'cart_item_tile.dart';

class CartItemsList extends ConsumerStatefulWidget {
  const CartItemsList({super.key});

  @override
  ConsumerState<CartItemsList> createState() => _CartItemsListState();
}

class _CartItemsListState extends ConsumerState<CartItemsList> {
  final ScrollController _scrollController = ScrollController();

  late List<FocusNode> cartFocusNodes;
  late List<FocusNode> plusFocusNodes;
  late List<FocusNode> minusFocusNodes;

  @override
  void initState() {
    super.initState();
    cartFocusNodes = [];
    plusFocusNodes = [];
    minusFocusNodes = [];
  }

  @override
  void dispose() {
    for (final node in cartFocusNodes) node.dispose();
    for (final node in plusFocusNodes) node.dispose();
    for (final node in minusFocusNodes) node.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _ensureVisible(FocusNode node) async {
    if (node.context != null) {
      await Scrollable.ensureVisible(
        node.context!,
        alignment: 0.5,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemQuantitiesProvider);

    // Initialize focus nodes if new items added
    while (cartFocusNodes.length < items.length) cartFocusNodes.add(FocusNode());
    while (plusFocusNodes.length < items.length) plusFocusNodes.add(FocusNode());
    while (minusFocusNodes.length < items.length) minusFocusNodes.add(FocusNode());

    return ListView.builder(
      controller: _scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final dishWithQty = items[index];
        final dish = dishWithQty.dish;
        final quantity = dishWithQty.quantity;

        final cartNode = cartFocusNodes[index];
        final plusNode = plusFocusNodes[index];
        final minusNode = minusFocusNodes[index];

        return Focus(
          focusNode: cartNode,
          onFocusChange: (hasFocus) {
            if (hasFocus) _ensureVisible(cartNode);
          },
          onKeyEvent: (node, event) {
            if (event is! KeyDownEvent) return KeyEventResult.ignored;

            // Navigate with arrow keys
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              plusNode.requestFocus();
              _ensureVisible(plusNode);
              return KeyEventResult.handled;
            }

            if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              minusNode.requestFocus();
              _ensureVisible(minusNode);
              return KeyEventResult.handled;
            }

            // Enter / select key
            if (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.select) {

              final idx = ref.read(itemQuantitiesProvider)
                  .indexWhere((e) => e.dish.id == dish.id);

              if (quantity == 0) {
                // First time: add 1 and move focus to plus
                ref.read(itemQuantitiesProvider.notifier)
                    .addItem(DishWithQuantity(dish: dish, quantity: 1));
                plusNode.requestFocus();
                _ensureVisible(plusNode);
              } else {
                // Already added: increment/decrement
                if (plusNode.hasFocus || (!plusNode.hasFocus && !minusNode.hasFocus)) {
                  ref.read(itemQuantitiesProvider.notifier).increment(idx);
                  plusNode.requestFocus();
                  _ensureVisible(plusNode);
                } else if (minusNode.hasFocus) {
                  ref.read(itemQuantitiesProvider.notifier).decrement(idx);
                  minusNode.requestFocus();
                  _ensureVisible(minusNode);
                }
              }
              return KeyEventResult.handled;
            }

            return KeyEventResult.ignored;
          },
          child: CartItemTile(
            title: dish.name ?? "Unknown",
            quantity: quantity,
            price: dish.dish_price,
            type: dish.dish_type,
            onIncrement: () {
              ref.read(itemQuantitiesProvider.notifier).increment(index);
              plusNode.requestFocus();
              _ensureVisible(plusNode);
            },
            onDecrement: () {
              ref.read(itemQuantitiesProvider.notifier).decrement(index);
              minusNode.requestFocus();
              _ensureVisible(minusNode);
            },
            plusFocusNode: plusNode,
            minusFocusNode: minusNode,
          ),
        );
      },
    );
  }
}
