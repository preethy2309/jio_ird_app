import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class StatusConnector extends StatelessWidget {
  final bool isSelected;

  const StatusConnector({required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: DottedLine(
        direction: Axis.horizontal,
        dashLength: 4,
        dashGapLength: 3,
        dashColor: isSelected ? Colors.grey : Colors.white38,
      ),
    );
  }
}
