import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/theme/app_colors.dart';

import '../../../../providers/cart_provider.dart';
import '../../../screens/cart_screen.dart';

class CartButton extends ConsumerStatefulWidget {
  const CartButton({super.key});

  @override
  ConsumerState<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends ConsumerState<CartButton> {
  bool cartFocused = false;

  @override
  Widget build(BuildContext context) {
    final totalCount = ref
        .watch(itemQuantitiesProvider)
        .fold(0, (sum, dishWithQty) => sum + dishWithQty.quantity);

    return Focus(
      onFocusChange: (hasFocus) => setState(() => cartFocused = hasFocus),
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.select ||
            event.logicalKey == LogicalKeyboardKey.enter) {
          _goToCart();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: _goToCart,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: cartFocused ? AppColors.primary : Colors.grey[800],
                borderRadius: BorderRadius.circular(26),
              ),
              child: const SizedBox(
                height: 26,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Go to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            if (totalCount > 0)
              Positioned(
                top: -6,
                right: -6,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$totalCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartScreen()),
    );
  }
}
