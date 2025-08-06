import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_button.dart';
import 'veg_toggle.dart';
import 'profile_icon.dart';

class MenuTopBar extends ConsumerWidget {
  const MenuTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏨 Title and Room
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In-Room Dining',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
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
          Spacer(),
          VegToggle(),
          Spacer(),
          CartButton(),
          Spacer(),
          ProfileIcon(),
        ],
      ),
    );
  }
}
