import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final FocusNode plusButtonFocusNode;
  final FocusNode minusButtonFocusNode;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.plusButtonFocusNode,
    required this.minusButtonFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: 100,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(38),
        ),
      ),
      SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AnimatedQtyButton(
              icon: Icons.add,
              onTap: onIncrement,
              focusNode: plusButtonFocusNode,
              onRight: () => minusButtonFocusNode.requestFocus(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            _AnimatedQtyButton(
              icon: Icons.remove,
              onTap: onDecrement,
              focusNode: minusButtonFocusNode,
              onLeft: () => plusButtonFocusNode.requestFocus(),
            ),
          ],
        ),
      ),
    ]);
  }
}

class _AnimatedQtyButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final FocusNode focusNode;
  final VoidCallback? onLeft;
  final VoidCallback? onRight;

  const _AnimatedQtyButton({
    required this.icon,
    required this.onTap,
    required this.focusNode,
    this.onLeft,
    this.onRight,
  });

  @override
  State<_AnimatedQtyButton> createState() => _AnimatedQtyButtonState();
}

class _AnimatedQtyButtonState extends State<_AnimatedQtyButton> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = widget.focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            widget.onLeft?.call();
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            widget.onRight?.call();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: InkWell(
        onTap: widget.onTap,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          width: _isFocused ? 36 : 28,
          height: _isFocused ? 36 : 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _isFocused ? Colors.amber : Colors.grey,
            shape: BoxShape.circle,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            child: Icon(
              widget.icon,
              color: _isFocused ? Colors.white : Colors.black,
              size: _isFocused ? 26 : 18, // only icon changes size
            ),
          ),
        ),
      ),
    );
  }
}
