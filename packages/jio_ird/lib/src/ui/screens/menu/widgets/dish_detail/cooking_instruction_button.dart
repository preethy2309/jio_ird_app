import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/dish_model.dart';
import '../../../../../notifiers/cart_notifier.dart';
import '../../../../../notifiers/meal_notifier.dart';
import '../../../../../providers/focus_provider.dart';
import '../../../../../providers/state_provider.dart';
import '../../../../../utils/helper.dart';
import '../../../../widgets/cooking_instruction_dialog.dart';

class CookingInstructionButton extends ConsumerWidget {
  final Dish dish;

  const CookingInstructionButton({
    super.key,
    required this.dish,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        height: 35,
        child: Focus(
          onKeyEvent: (node, event) => _handleKeyEvent(event, ref),
          child: ElevatedButton(
            focusNode: ref.watch(cookingInstructionFocusNodeProvider),
            onPressed: () => _showInstructionDialog(context, ref),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) => states.contains(WidgetState.focused)
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white70,
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) => states.contains(WidgetState.focused)
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.black,
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            child: Text(
              (dish.cookingRequest?.isEmpty ?? true)
                  ? "Add Cooking Instructions"
                  : "Edit Cooking Instructions",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  KeyEventResult _handleKeyEvent(KeyEvent event, WidgetRef ref) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _focusBack(ref);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _focusBack(WidgetRef ref) {
    if (ref.read(showCategoriesProvider)) {
      final index = ref.read(selectedCategoryProvider).clamp(0, double.maxFinite.toInt());
      ref.read(categoryFocusNodeProvider(index)).requestFocus();
    } else if (hasSubCategories(ref) && ref.read(showSubCategoriesProvider)) {
      final index = ref.read(selectedSubCategoryProvider).clamp(0, double.maxFinite.toInt());
      ref.read(subCategoryFocusNodeProvider(index)).requestFocus();
    } else {
      final index = ref.read(focusedDishProvider).clamp(0, double.maxFinite.toInt());
      ref.read(dishFocusNodeProvider(index)).requestFocus();
    }
  }

  void _showInstructionDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: dish.cookingRequest ?? '');
    showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (_) => CookingInstructionDialog(
        dishName: dish.name,
        controller: controller,
        onSave: (text) {
          ref.read(itemQuantitiesProvider.notifier).updateCookingInstruction(dish.id, text);
          ref.read(mealsProvider.notifier).updateDishCookingInstruction(dish.id, text);
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }
}
