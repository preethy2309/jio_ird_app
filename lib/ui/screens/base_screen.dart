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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38, right: 32, top: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuTopBar(
                  title: title,
                  description: description,
                  icons: icons,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0x80000000),
      bottomNavigationBar: const BottomLayout(),
    );
  }
}
