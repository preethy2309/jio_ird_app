import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/providers/focus_provider.dart';
import 'package:jio_ird/ui/theme/app_colors.dart';
import 'package:jio_ird/ui/widgets/veg_indicator.dart';

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
    final focusNode = ref.watch(vegToggleFocusNodeProvider);

    return Focus(
      focusNode: focusNode,
      onFocusChange: (hasFocus) {
        setState(() => toggleFocused = hasFocus);
        if (hasFocus) {
          ref.read(focusedDishProvider.notifier).state = -2;
        }
      },
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          final key = event.logicalKey;

          if (key == LogicalKeyboardKey.select ||
              key == LogicalKeyboardKey.enter) {
            ref.read(vegOnlyProvider.notifier).state = !vegOnly;
            return KeyEventResult.handled;
          }

          if (key == LogicalKeyboardKey.arrowLeft) {
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
            borderRadius: BorderRadius.circular(26),
          ),
          child: SizedBox(
            height: 26,
            child: Row(
              children: [
                const VegIndicator(),
                const SizedBox(width: 10),
                const Text('Veg Only', style: TextStyle(color: Colors.white)),
                const SizedBox(width: 8),
                SizedBox(
                  width: 46,
                  height: 26,
                  child: Switch(
                    activeColor: AppColors.primary,
                    autofocus: true,
                    value: vegOnly,
                    onChanged: (value) =>
                        ref.read(vegOnlyProvider.notifier).state = value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
