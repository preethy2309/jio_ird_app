import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../providers/state_provider.dart';
import '../../../../../utils/helper.dart';

Future<bool> handleBackNavigation(WidgetRef ref, bool isFocused) async {
  if (isFocused) {
    if (hasSubCategories(ref)) {
      ref.read(showSubCategoriesProvider.notifier).state = true;
    } else {
      ref.read(showCategoriesProvider.notifier).state = true;
    }
  }
  return true;
}

KeyEventResult handleSubCategoryKeyEvent(
    KeyEvent event, WidgetRef ref, int index, bool noDishes) {
  if (event is! KeyDownEvent) return KeyEventResult.ignored;

  if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
    ref.read(showCategoriesProvider.notifier).state = true;
    ref.read(selectedSubCategoryProvider.notifier).state = -1;
    return KeyEventResult.handled;
  }

  if ((event.logicalKey == LogicalKeyboardKey.arrowRight ||
      event.logicalKey == LogicalKeyboardKey.enter ||
      event.logicalKey == LogicalKeyboardKey.select)) {
    if (!noDishes) {
      handleSubCategorySelect(ref, index);
      return KeyEventResult.handled;
    }
  }
  return KeyEventResult.ignored;
}

void handleSubCategoryFocus(WidgetRef ref, int index, bool hasFocus) {
  ref.read(focusedSubCategoryProvider.notifier).state = index;
  if (hasFocus) {
    ref.read(selectedSubCategoryProvider.notifier).state = index;
    ref.read(selectedDishProvider.notifier).state = -1;
    ref.read(focusedDishProvider.notifier).state = -1;
  }
}

void handleSubCategorySelect(WidgetRef ref, int index) {
  ref.read(selectedSubCategoryProvider.notifier).state = index;
  ref.read(showSubCategoriesProvider.notifier).state = false;
  ref.read(focusedDishProvider.notifier).state = 0;
  ref.read(selectedDishProvider.notifier).state = 0;
}
