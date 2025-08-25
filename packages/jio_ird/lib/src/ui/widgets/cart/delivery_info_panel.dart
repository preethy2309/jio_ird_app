import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../notifiers/cart_notifier.dart';
import '../../../providers/state_provider.dart';

class DeliveryInfoPanel extends ConsumerWidget {
  const DeliveryInfoPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemQuantitiesProvider);

    final totalPrice = items.fold<double>(
      0,
      (sum, dishWithQty) {
        final price = double.tryParse(dishWithQty.dish.dish_price) ?? 0.0;
        return sum + price * dishWithQty.quantity;
      },
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            icon: Icons.schedule,
            title: "Delivery Schedule",
            value: "10 PM",
            boldValue: true,
          ),
          const SizedBox(height: 10),
          _buildGuestCount(),
          const SizedBox(height: 10),
          _buildInfoRow(
            icon: Icons.warning_amber_rounded,
            title: "Allergies and Dietary Restrictions",
            value: "None",
            trailing: const Icon(Icons.chevron_right, color: Colors.white),
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            icon: Icons.chat_bubble_outline,
            title: "Specific Instructions",
            value: "None",
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.focused)) {
                    return Colors.amber;
                  }
                  return Colors.white;
                }),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 24),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              onPressed: () {
                ref.read(orderPlacedProvider.notifier).state = true;

              },
              child: Text(
                "Place order - Rs. ${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    bool boldValue = false,
    Widget? trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.white70),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            if (trailing != null) ...[
              const Spacer(),
              trailing,
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: boldValue ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildGuestCount() {
    return Row(
      children: [
        const Icon(Icons.person, size: 18, color: Colors.white70),
        const SizedBox(width: 8),
        const Text(
          "Guest in the room",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              _buildQtyButton(Icons.add),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "1",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              _buildQtyButton(Icons.remove),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQtyButton(IconData icon) {
    return InkWell(
      onTap: () => {},
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: 16),
      ),
    );
  }
}
