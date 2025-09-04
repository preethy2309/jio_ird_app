import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final int index;
  final bool isSelected;
  final bool isFocused;
  final bool isLastIndex;
  final FocusNode focusNode;
  final VoidCallback onSelect;
  final ValueChanged<bool> onFocusChange;
  final VoidCallback onLeft;

  const CategoryTile({
    super.key,
    required this.title,
    required this.index,
    required this.isSelected,
    required this.isFocused,
    required this.isLastIndex,
    required this.focusNode,
    required this.onSelect,
    required this.onFocusChange,
    required this.onLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onKeyEvent: _handleKeyEvent,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 36,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _textColor(context),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.enter:
      case LogicalKeyboardKey.select:
        onSelect();
        return KeyEventResult.handled;

      case LogicalKeyboardKey.arrowDown:
        if (isLastIndex) return KeyEventResult.handled;
        break;

      case LogicalKeyboardKey.arrowLeft:
        onLeft();
        return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  Color _backgroundColor(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    if (isFocused) return colors.primary;
    if (isSelected) return Colors.white70;
    return colors.secondary;
  }

  Color _textColor(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    if (isFocused || isSelected) return colors.onPrimary;
    return colors.onSecondary;
  }
}
