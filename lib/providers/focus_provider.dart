import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_provider.dart';

/// A generic focus node provider based on a unique key/index.
/// It automatically disposes the node when not used.
final focusNodeProvider =
    Provider.family.autoDispose<FocusNode, String>((ref, key) {
  final node = FocusNode();
  ref.onDispose(() => node.dispose());
  return node;
});

/// Use this for indexed lists, like dish or category items
FocusNode useIndexedFocusNode(WidgetRef ref, String prefix, int index) {
  return ref.watch(focusNodeProvider('$prefix-$index'));
}

/// Category focus nodes
final categoryFocusNodesProvider = Provider.autoDispose<List<FocusNode>>((ref) {
  final categories = ref.watch(mealsProvider).maybeWhen(
        data: (categories) => categories,
        orElse: () => [],
      );

  final nodes = List<FocusNode>.generate(categories.length, (_) => FocusNode());
  ref.onDispose(() {
    for (final node in nodes) {
      node.dispose();
    }
  });
  return nodes;
});

/// Dish focus nodes
final dishFocusNodesProvider = Provider.autoDispose<List<FocusNode>>((ref) {
  final vegOnly = ref.watch(vegOnlyProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final meals = ref.watch(mealsProvider).maybeWhen(
        data: (categories) => categories,
        orElse: () => [],
      );

  final selectedCat = meals.isNotEmpty && selectedCategory < meals.length
      ? meals[selectedCategory]
      : null;

  final subCats = selectedCat?.sub_categories ?? [];
  final allDishes = subCats.expand((s) => s.dishes ?? []).toList();

  final filtered = vegOnly
      ? allDishes.where((d) => d.dish_type.toLowerCase() == 'veg').toList()
      : allDishes;

  final nodes = List<FocusNode>.generate(filtered.length, (_) => FocusNode());
  ref.onDispose(() {
    for (final node in nodes) {
      node.dispose();
    }
  });
  return nodes;
});


final toggleFocusProvider = Provider.autoDispose<FocusNode>((ref) {
  final node = FocusNode();
  ref.onDispose(() => node.dispose());
  return node;
});

final cartFocusProvider = Provider.autoDispose<FocusNode>((ref) {
  final node = FocusNode();
  ref.onDispose(() => node.dispose());
  return node;
});

final profileFocusProvider = Provider.autoDispose<FocusNode>((ref) {
  final node = FocusNode();
  ref.onDispose(() => node.dispose());
  return node;
});
