import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../providers/focus_provider.dart';
import '../../../../../providers/state_provider.dart';
import 'dish_list_item.dart';

class DishList extends ConsumerStatefulWidget {
  final List<dynamic> dishes;

  const DishList({super.key, required this.dishes});

  @override
  ConsumerState<DishList> createState() => _DishListState();
}

class _DishListState extends ConsumerState<DishList> {
  final ScrollController _scrollController = ScrollController();

  late List<FocusNode> plusFocusNodes;
  late List<FocusNode> minusFocusNodes;

  @override
  void initState() {
    super.initState();
    _initFocusNodes();
  }

  void _initFocusNodes() {
    plusFocusNodes = List.generate(widget.dishes.length, (_) => FocusNode());
    minusFocusNodes = List.generate(widget.dishes.length, (_) => FocusNode());
  }

  @override
  void didUpdateWidget(DishList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dishes.length != widget.dishes.length) {
      _disposeNodes();
      _initFocusNodes();
    }
  }

  void _disposeNodes() {
    for (final n in plusFocusNodes) n.dispose();
    for (final n in minusFocusNodes) n.dispose();
  }

  @override
  void dispose() {
    _disposeNodes();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDish = ref.watch(selectedDishProvider);
    final focusedDish = ref.watch(focusedDishProvider);

    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.dishes.length,
      itemBuilder: (context, index) {
        final dish = widget.dishes[index];
        final dishNode = ref.watch(dishFocusNodeProvider(index));

        return DishListItem(
          dish: dish,
          index: index,
          dishNode: dishNode,
          plusNode: plusFocusNodes[index],
          minusNode: minusFocusNodes[index],
          scrollController: _scrollController,
          isSelected: index == selectedDish,
          isFocused: index == focusedDish,
        );
      },
    );
  }
}
