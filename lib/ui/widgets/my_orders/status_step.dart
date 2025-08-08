import 'package:flutter/material.dart';

class StatusStep extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final bool isSelected;

  const StatusStep({
    required this.icon,
    required this.label,
    this.active = false,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon,
            size: 20,
            color: active
                ? const Color(0xFFD4AF6A)
                : isSelected
                ? Colors.grey
                : Colors.white38),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: active
                ? const Color(0xFFD4AF6A)
                : isSelected
                ? Colors.grey
                : Colors.white38,
          ),
        ),
      ],
    );
  }
}