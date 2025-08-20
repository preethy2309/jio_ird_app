import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/dish_model.dart';
import '../veg_indicator.dart';
import 'cooking_instruction_dialog.dart';

class DishDetail extends ConsumerWidget {
  final Dish? dish;
  final String categoryName;

  const DishDetail({super.key, required this.dish, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (dish == null) {
      return const Center(child: Text("No dish available"));
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (dish!.dish_image.isNotEmpty)
              Image.network(
                dish!.dish_image,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/default_dish.png',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  );
                },
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                VegIndicator(
                    color: (dish!.dish_type.toLowerCase() == 'veg'
                        ? Colors.green
                        : Colors.red)),
                const SizedBox(width: 6),
                Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 6),
            Text(
              dish!.name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 6),
            Text(
              dish!.description,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 6),
            // Text(
            //   '₹${dish!.dish_price}',
            //   style: const TextStyle(color: Colors.amber),
            // ),
            Center(
              child: SizedBox(
                width: 250,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        TextEditingController instructionController =
                            TextEditingController();
                        return CookingInstructionDialog(
                          dishName: "Rawa Idli",
                          controller: instructionController,
                          onSave: () {
                            // Save logic
                            Navigator.of(context).pop();
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                        if (states.contains(WidgetState.focused)) {
                          return Theme.of(context).colorScheme.primary;
                        }
                        return Colors.white70;
                      },
                    ),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Text(
                    (dish!.cooking_request == null ||
                            dish!.cooking_request!.isEmpty)
                        ? "Add Cooking Instructions"
                        : "Edit Cooking Instructions",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
