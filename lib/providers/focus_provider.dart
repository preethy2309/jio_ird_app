import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state_provider.dart';

/// Auto-dispose FocusNode for category item
final categoryFocusNodeProvider = Provider.family
    .autoDispose<FocusNode, int>((ref, index) {
  final node = FocusNode();
  ref.onDispose(() => node.dispose());
  return node;
});

/// Auto-dispose FocusNode for dish item
final dishFocusNodeProvider = Provider.family
    .autoDispose<FocusNode, int>((ref, index) {
  final node = FocusNode();
  ref.onDispose(() => node.dispose());
  return node;
});

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
  final allDishes = subCats
      .expand((s) => (s.dishes ?? []) as Iterable)
      .toList();


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

final cartTabFocusNodeProvider = Provider<FocusNode>((ref) {
  final node = FocusNode();
  ref.onDispose(() => node.dispose());
  return node;
});

final myOrdersTabFocusNodeProvider = Provider<FocusNode>((ref) {
  final node = FocusNode();
  ref.onDispose(() => node.dispose());
  return node;
});
