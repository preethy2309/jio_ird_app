import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class BottomLayout extends StatelessWidget {
  const BottomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                width: 20,
                height: 24,
                'assets/images/ok.png',
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                width: 8,
                height: 16,
              ),
              const Text('Select',
                  style: TextStyle(color: AppColors.textAmber, fontSize: 12)),
            ],
          ),
          const SizedBox(width: 60),
          Row(
            children: [
              Image.asset(
                width: 16,
                height: 16,
                'assets/images/down_arrow.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 4),
              Image.asset(
                width: 16,
                height: 16,
                'assets/images/up_arrow.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              const Text('Navigate',
                  style: TextStyle(color: AppColors.textAmber, fontSize: 12)),
            ],
          ),
          const SizedBox(width: 60),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const SizedBox(width: 25, height: 16),
              ),
              const SizedBox(width: 8),
              const Text('Clear App',
                  style: TextStyle(color: AppColors.textAmber, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
