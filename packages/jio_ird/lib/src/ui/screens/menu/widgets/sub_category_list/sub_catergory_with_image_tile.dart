import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jio_ird/src/ui/screens/menu/widgets/sub_category_list/sub_category_helper.dart';

import '../../../../../data/models/food_item.dart';
import '../../../../../providers/focus_provider.dart';
import '../../../../widgets/back_handler.dart';
import '../dish_image.dart';

class SubCategoryWithImageTile extends ConsumerWidget {
  final FoodItem subCategory;
  final int index;
  final bool isFocused;
  final bool noDishes;
  final bool showCategories;
  final ValueChanged<bool> onFocusChange;

  const SubCategoryWithImageTile({
    super.key,
    required this.subCategory,
    required this.index,
    required this.isFocused,
    required this.noDishes,
    required this.showCategories,
    required this.onFocusChange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = ref.watch(subCategoryMainFocusNodeProvider(index));

    return BackHandler(
      canPop: false,
      onBack: () => handleBackNavigation(ref, isFocused),
      child: Focus(
        skipTraversal: showCategories,
        canRequestFocus: !showCategories,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        onKeyEvent: (node, event) =>
            handleSubCategoryKeyEvent(event, ref, index, noDishes),
        child: InkWell(
          child: Container(
            height: 76,
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isFocused
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                DishImage(
                  imageUrl: subCategory.dishes?.isNotEmpty == true
                      ? subCategory.dishes!.first.dishImage
                      : null,
                  width: 75,
                  height: 75,
                  borderRadius: 6,
                  fallbackWidth: 45,
                  fallbackHeight: 45,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    subCategory.categoryName ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
