import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/external_providers.dart';
import '../widgets/menu/bottom_layout.dart';
import '../widgets/menu/menu_top_bar/menu_top_bar.dart';

class BaseScreen extends ConsumerWidget {
  final String title;
  final String? description;
  final List<Widget>? icons;
  final Widget child;

  const BaseScreen({
    super.key,
    required this.title,
    this.description,
    this.icons,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomBar = ref.watch(bottomBarProvider);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              package: 'jio_ird',
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
                  description: description ?? "",
                  icons: icons,
                ),
                const SizedBox(height: 20),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0x80000000),
      bottomNavigationBar: bottomBar ?? const BottomLayout(),
    );
  }
}
