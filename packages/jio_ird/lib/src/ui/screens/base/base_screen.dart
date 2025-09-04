import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/ui/screens/base/widgets/background_image.dart';
import 'package:jio_ird/src/ui/screens/base/widgets/menu_top_bar/menu_top_bar.dart';

import '../../../providers/external_providers.dart';
import 'widgets/bottom_bar/bottom_layout.dart';

class BaseScreen extends ConsumerWidget {
  final String title;
  final List<Widget>? icons;
  final Widget child;

  const BaseScreen({
    super.key,
    required this.title,
    this.icons,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomBar = ref.watch(bottomBarProvider);
    final guestInfo = ref.watch(guestDetailsProvider);
    final bgImage = ref.watch(resolvedBackgroundImageProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: bgImage ??
                const AssetImage('assets/images/bg.png', package: 'jio_ird'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.only(left: 38, right: 32, top: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuTopBar(
              title: title,
              description: guestInfo.roomNo ?? "",
              icons: icons,
            ),
            const SizedBox(height: 20),
            Expanded(child: child),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar ?? const BottomLayout(),
    );
  }
}
