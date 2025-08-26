import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/state_provider.dart';

bool hasSubCategories(WidgetRef ref) {
  final categories = ref.read(mealsProvider);
  final selectedCategory = ref.read(selectedCategoryProvider);

  if (categories.isEmpty ||
      selectedCategory < 0 ||
      selectedCategory >= categories.length) {
    return false;
  }

  final selectedCat = categories[selectedCategory];
  return selectedCat.sub_categories != null &&
      selectedCat.sub_categories!.isNotEmpty;
}
