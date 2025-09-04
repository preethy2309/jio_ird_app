import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/menu_content.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/menu_loading_view.dart';

import '../../../notifiers/meal_notifier.dart';
import '../../../providers/external_providers.dart';
import '../base/base_screen.dart';
import '../base/widgets/menu_top_bar/cart_button.dart';
import '../base/widgets/menu_top_bar/veg_toggle.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(mealsProvider);
    final menuTitle = ref.watch(menuTitleProvider);

    if (categories.isEmpty) {
      return BaseScreen(title: menuTitle, child: const MenuLoadingView());
    }

    return BaseScreen(
      title: menuTitle,
      icons: const [VegToggle(), CartButton()],
      child: MenuContent(categories: categories),
    );
  }
}
