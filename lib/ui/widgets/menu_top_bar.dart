import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodel/meals_notifier.dart';

class MenuTopBar extends ConsumerWidget {
  const MenuTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vegOnly = ref.watch(vegOnlyProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In-Room Dining',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Arial',
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Room No. 204',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white30,
                ),
              ),
            ],
          ),
          const Spacer(),

          // ✅ Veg Only Toggle with Green Icon
          Row(
            children: [
              // Veg Icon
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text('Veg Only', style: TextStyle(color: Colors.white)),
              const SizedBox(width: 8),
              Switch(
                value: vegOnly,
                onChanged: (value) =>
                    ref.read(vegOnlyProvider.notifier).state = value,
              ),
            ],
          ),

          const Spacer(),

          // ✅ Go to Cart Button
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement cart navigation
            },
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            label: const Text('Go to Cart'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),

          const Spacer(),

          // ✅ Profile Icon
          Container(
            decoration: const BoxDecoration(
              color: Colors.white12,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6),
            child: const Icon(Icons.person, color: Colors.amber, size: 40),
          ),
        ],
      ),
    );
  }
}
