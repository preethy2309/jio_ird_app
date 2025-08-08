import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/ui/widgets/header.dart';

import 'cart_button.dart';
import 'profile_icon.dart';
import 'veg_toggle.dart';

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
          Header(
            title: "In-Room Dining",
            description: "Room No. 204",
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
