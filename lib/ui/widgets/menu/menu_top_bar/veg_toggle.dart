import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/providers/focus_provider.dart';

import '../../../../providers/state_provider.dart';

class VegToggle extends ConsumerStatefulWidget {
  const VegToggle({super.key});

  @override
  ConsumerState<VegToggle> createState() => _VegToggleState();
}

class _VegToggleState extends ConsumerState<VegToggle> {
  bool toggleFocused = false;

  @override
  Widget build(BuildContext context) {
    final vegOnly = ref.watch(vegOnlyProvider);
    final toggleFocusNode = ref.watch(toggleFocusProvider);

    return Focus(
      focusNode: toggleFocusNode,
      onFocusChange: (hasFocus) => setState(() => toggleFocused = hasFocus),
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          final key = event.logicalKey;

          if (key == LogicalKeyboardKey.select || key == LogicalKeyboardKey.enter) {
            ref.read(vegOnlyProvider.notifier).state = !vegOnly;
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: () => ref.read(vegOnlyProvider.notifier).state = !vegOnly,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: toggleFocused ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text('Veg Only', style: TextStyle(color: Colors.white)),
              const SizedBox(width: 8),
              Switch(
                value: vegOnly,
                onChanged: (value) =>
                ref.read(vegOnlyProvider.notifier).state = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
