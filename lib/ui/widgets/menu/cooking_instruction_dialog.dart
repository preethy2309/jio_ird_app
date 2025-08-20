import 'package:flutter/material.dart';

class CookingInstructionDialog extends StatelessWidget {
  final String dishName;
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const CookingInstructionDialog({
    super.key,
    required this.dishName,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black45, // transparent to show custom container
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        width: 500,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1), // white border
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Dish Title
              Text(
                dishName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Text Field expands
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  expands: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: "Add your cooking instruction here",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cancel Button
                  ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 15),

                  // Save Instructions Button
                  ElevatedButton(
                    onPressed: onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Save Instructions",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
