import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tabs enum
enum CartTab { items, info }

/// StateProvider to manage selected tab
final selectedCartTabProvider = StateProvider<CartTab>((ref) => CartTab.items);

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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTab(
          label: "Cart Items",
          isSelected: selectedTab == CartTab.items,
          focusNode: itemsTabFocusNode,
          onSelect: () {
            ref.read(selectedCartTabProvider.notifier).state = CartTab.items;
          },
        ),
        const SizedBox(width: 30),
        _buildTab(
          label: "Delivery Info",
          isSelected: selectedTab == CartTab.info,
          focusNode: infoTabFocusNode,
          onSelect: () {
            ref.read(selectedCartTabProvider.notifier).state = CartTab.info;
          },
        ),
      ],
    );
  }

  Widget _buildTab({
    required String label,
    required bool isSelected,
    required FocusNode focusNode,
    required VoidCallback onSelect,
  }) {
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
      child: GestureDetector(
        onTap: onSelect,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFE0B054)
                : (focusNode.hasFocus ? Colors.white24 : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
