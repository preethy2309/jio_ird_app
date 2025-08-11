import 'package:flutter/material.dart';
import 'package:jio_ird/ui/widgets/menu/bottom_layout.dart';
import 'package:jio_ird/ui/widgets/menu/menu_top_bar/menu_top_bar.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget>? icons;
  final Widget child;

  const BaseScreen({
    super.key,
    required this.title,
    required this.description,
    this.icons,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuTopBar(
              title: title,
              description: description,
              icons: icons,
            ),
            Expanded(child: child), // your screen content
          ],
        ),
      ),
      bottomNavigationBar: const BottomLayout(),
    );
  }
}
