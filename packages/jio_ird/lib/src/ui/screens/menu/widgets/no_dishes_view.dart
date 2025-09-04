import 'package:flutter/material.dart';

class NoDishesView extends StatelessWidget {
  const NoDishesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text(
          "No dishes available",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}
