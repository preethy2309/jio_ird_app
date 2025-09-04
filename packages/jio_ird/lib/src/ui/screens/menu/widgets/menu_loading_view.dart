import 'package:flutter/material.dart';
import '../../../widgets/shimmer_loader.dart';

class MenuLoadingView extends StatelessWidget {
  const MenuLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: List.generate(
            6,
                (index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: ShimmerLoader(height: 40, width: 180),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          children: List.generate(
            5,
                (index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: ShimmerLoader(height: 75, width: 240),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoader(height: 200, width: double.infinity),
              SizedBox(height: 16),
              ShimmerLoader(height: 20, width: 150),
              SizedBox(height: 8),
              ShimmerLoader(height: 20, width: 200),
              SizedBox(height: 8),
              ShimmerLoader(height: 20, width: 120),
            ],
          ),
        ),
      ],
    );
  }
}
