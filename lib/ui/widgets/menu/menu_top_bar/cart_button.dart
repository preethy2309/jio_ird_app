import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/focus_provider.dart';
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
    final cartFocusNode = ref.watch(cartFocusProvider);
    return Focus(
      focusNode: cartFocusNode,
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: cartFocused ? Colors.amber : Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.white),
              SizedBox(width: 8),
              Text('Go to Cart', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  void _goToCart() {
    debugPrint('Go to Cart pressed');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartScreen()),
    );
  }
}
