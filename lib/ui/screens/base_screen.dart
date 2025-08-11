import 'package:flutter/material.dart';
import 'package:jio_ird/ui/widgets/menu/bottom_layout.dart';

import '../widgets/header.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const BaseScreen({
    super.key,
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: title, description: description),
            const SizedBox(height: 20),
            Expanded(child: child), // your screen content
          ],
        ),
      ),
      bottomNavigationBar: const BottomLayout(),
    );
  }
}
