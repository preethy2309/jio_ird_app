import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CartTab { cart, orders }

final selectedCartTabProvider = StateProvider<CartTab>((ref) => CartTab.cart);

class TabSwitcher extends ConsumerStatefulWidget {
  const TabSwitcher({super.key});

  @override
  ConsumerState<TabSwitcher> createState() => _TabSwitcherState();
}

class _TabSwitcherState extends ConsumerState<TabSwitcher> {
  late FocusNode itemsTabFocusNode;
  late FocusNode infoTabFocusNode;

  @override
  void initState() {
    super.initState();
    itemsTabFocusNode = FocusNode();
    infoTabFocusNode = FocusNode();

    // Set initial focus on first tab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemsTabFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    itemsTabFocusNode.dispose();
    infoTabFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(selectedCartTabProvider);

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border.all(color: Colors.grey.shade800, width: 1.5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab(
            label: "Cart",
            isSelected: selectedTab == CartTab.cart,
            focusNode: itemsTabFocusNode,
            onSelect: () {
              ref.read(selectedCartTabProvider.notifier).state = CartTab.cart;
            },
          ),
          const SizedBox(width: 4),
          _buildTab(
            label: "My Orders",
            isSelected: selectedTab == CartTab.orders,
            focusNode: infoTabFocusNode,
            onSelect: () {
              ref.read(selectedCartTabProvider.notifier).state = CartTab.orders;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool isSelected,
    required FocusNode focusNode,
    required VoidCallback onSelect,
  }) {
    final bool isFocused = focusNode.hasFocus;

    return Focus(
      focusNode: focusNode,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.select)) {
          onSelect();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: InkWell(
        onTap: onSelect,
        child: AnimatedContainer(
          width: 120,
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isFocused ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isFocused ? Colors.black : Colors.amber,
              fontSize: 16,
              fontWeight: isFocused ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
