import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  final Color color;
  const BackArrowButton({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Color(0x33FFFFFF),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
