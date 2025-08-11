import 'package:flutter/material.dart';
import 'package:jio_ird/ui/widgets/header.dart';
import 'package:jio_ird/ui/widgets/menu/menu_top_bar/profile_icon.dart';

class MenuTopBar extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget>? icons;

  const MenuTopBar({
    super.key,
    required this.title,
    required this.description,
    this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Header(
          title: title,
          description: description,
        ),
        if (icons != null && icons!.isNotEmpty) ...[
          for (int i = 0; i < icons!.length; i++) ...[
            const Spacer(),
            icons![i],
          ],
        ],
        const Spacer(),
        const ProfileIcon()
      ],
    );
  }
}
